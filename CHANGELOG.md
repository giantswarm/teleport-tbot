# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Add cronjob to cleanup leftover teleport-kubeconfigs for deleted clusters.

## [0.1.1] - 2024-08-21

### Added

- Label to Kubernetes secret created by teleport-tbot.

## [0.1.0] - 2024-08-21

### Changed

- Use teleport v16.1.4

## [0.0.9] - 2024-08-20

### Fixed

- Fixes an issue in tbot config file that caused tbot pod to CrashLoopBackOff.

## [0.0.8] - 2024-08-20

### Changed

- Outputs is now configurable.
- Certificate TTL value increased and configurable.

## [0.0.7] - 2024-08-19

### Added

- Added enabled flag to conditionally deploy helm chart.

### Changed

- Push to app catalog and app collection (CAPZ).

### Fixed

- Fixed potential vulnerability on `devctl` generated `github-workflows`.

## [0.0.6] - 2024-05-06

### Fixed

- Fixed cilium network policy, added `cluster` entity to egress rule.

### Changed

- Remove push to app catalog: default, control plane, app collections
- Switched to use recommended `proxy_server` over `auth_server` in tbot config.

## [0.0.5] - 2024-03-21

### Changed

- Removed chart tests
- Use standalone tbot-distroless image v15.1.7

## [0.0.4] - 2024-02-29

### Changed

- Rename identity output secret name

## [0.0.3] - 2024-02-28

### Fixed

- Chart to use `.Release.Namespace` namespace

## [0.0.2] - 2024-02-27

### Fixed

- Image `gsoci.azurecr.io/giantswarm/teleport-tbot:14.1.3` not found
- Duplicate `-tbot` in resource name

## [0.0.1] - 2024-02-22

- added: initial commits for teleport-tbot

[Unreleased]: https://github.com/giantswarm/teleport-tbot/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/giantswarm/teleport-tbot/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.9...v0.1.0
[0.0.9]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.8...v0.0.9
[0.0.8]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.7...v0.0.8
[0.0.7]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.6...v0.0.7
[0.0.6]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/giantswarm/teleport-tbot/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/giantswarm/teleport-tbot/releases/tag/v0.0.1
