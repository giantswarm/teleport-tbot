{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
app: {{ include "name" . | quote }}
{{ include "labels.selector" . }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "io.giantswarm.application.team" | default "shield" | quote }}
app.kubernetes.io/version: {{ .Chart.Version | replace "+" "_" | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app.kubernetes.io/name: {{ include "name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Name of tbot's credential lifetime key. tbot 17.3.0 renamed certificate_ttl to
credential_ttl and tbot reads a v2 config strictly, so an older tbot refuses to
start on the new key. The key is chosen from the tbot image tag: certificate_ttl
only when the tag (optional leading "v" stripped) starts with MAJOR.MINOR.PATCH
and that prefix is older than 17.3.0 (any suffix is ignored); credential_ttl
otherwise, including non-semver tags.
*/}}
{{- define "teleport-tbot.ttlKey" -}}
{{- $v := regexFind "^[0-9]+\\.[0-9]+\\.[0-9]+" (.Values.teleport.teleportVersion | toString | trimPrefix "v") -}}
{{- if and $v (semverCompare "<17.3.0" $v) -}}certificate_ttl{{- else -}}credential_ttl{{- end -}}
{{- end -}}

{{/*
Credential lifetime: credential_ttl, else the deprecated certificate_ttl, else 24h.
*/}}
{{- define "teleport-tbot.credentialTTL" -}}
{{- .Values.credential_ttl | default .Values.certificate_ttl | default "24h" -}}
{{- end -}}
