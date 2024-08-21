{{- if .Values.enabled }}
apiVersion: batch/v1
kind: CronJob
metadata:
  name: clean-{{ include "resource.default.name" . }}-kubeconfigs
  namespace: {{ include "resource.default.namespace"  . }}
  labels:
  {{- include "labels.common" . | nindent 4 }}
spec:
  schedule: "0 * * * *"  # Runs every hour
  jobTemplate:
    spec:
      template:
        metadata:
          labels:
            app.kubernetes.io/name: tbot
        spec:
          serviceAccountName: {{ include "resource.default.name"  . }}
          securityContext:
            runAsUser: {{ .Values.pod.user.id }}
            runAsGroup: {{ .Values.pod.group.id }}
            {{- with .Values.podSecurityContext }}
              {{- . | toYaml | nindent 12 }}
            {{- end }}
          restartPolicy: OnFailure
          containers:
          - name: cleanup-teleport-kubeconfigs
            image: {{ .Values.registry.domain }}/{{ .Values.cronjob.image.name }}:{{ .Values.cronjob.image.tag }}
            securityContext:
            {{- with .Values.containerSecurityContext }}
              {{- . | toYaml | nindent 14 }}
            {{- end }}
            command:
            - /bin/sh
            - -c
            - |
              NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
              secrets=$(kubectl get secrets -n "$NAMESPACE" -l app.kubernetes.io/managed-by=teleport-tbot -o custom-columns=:metadata.name --no-headers)
              for secret in $secrets; do
                cluster_id=$(echo "$secret" | sed 's/^teleport-\(.*\)-kubeconfig$/\1/')
                cluster_name=$(kubectl get clusters.cluster.x-k8s.io -l cluster.x-k8s.io/cluster-name="$cluster_id" -A -o name)
                if [ -z "$cluster_name" ]; then
                  echo "Cluster ${cluster_id} doesn't exist, deleting the secret."
                  echo kubectl delete secret $secret -n $NAMESPACE
                else
                  echo "Cluster ${cluster_id} exist, skipping secret."
                fi
              done
{{- end }}
