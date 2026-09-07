# Changelog

All notable changes to the ZD Cloud plan and platform. Dated, with the reason, because a platform whose history nobody can explain is a platform nobody can safely change.

## [0.1.1] — 2026-09-08

### Added
- `docs/09-VALIDATION-STATUS.md` — confidence level for every claim in the repository, plus a ten-entry register of the assumptions most likely to be wrong.
- `docs/runbooks/boot-01-day-one.md` — a five-day lab on one spare machine that falsifies the three riskiest assumptions before hardware is ordered.

### Verified
- All 8 `platform/` YAML and JSON files parse.
- `apps/mills/app.yaml` validates against `schemas/app.schema.json`.
- The schema's inline-secret rule was negative-tested and does reject `password=` values in `env`.

### Note
- Nothing else in this repository has been executed. The plan was written without access to Windows Server or hardware.

## [0.1.0] — 2026-09-08

### Added
- Repository scaffold, documentation order, `platform/` layout, the rule that every change is an ADR + changelog line + commit.
- **ADR-0001 … ADR-0031** — the complete decision record for the Windows-first platform (`docs/01-DECISIONS.md`, one file each under `docs/adr/`).
- **Master plan v0.1.0** — targets as numbers, fourteen capabilities mapped to Windows-native implementations, two-site topology, eight principles, seven phases with exit gates, external dependencies, staffing, three-year cost, hybrid checkpoint.
- **Application–infrastructure map** — every host, VM, Service Fabric application and business application (Mills, loan app, AGIS, ML pipelines, Zaraat Dost AI, the console) traced to identity, port, data store, bucket, secret path, backup, SLO and alert.
- **Security architecture** — threat model, hardware root of trust, tiered AD, WDAC/Authenticode, IPsec east–west, data protection, detection and paging rules, evidence pack, delivery-pipeline security.
- **Network and sites** — eleven zones, addressing, edge, RDMA storage fabric, egress proxy, Site B bandwidth, power sequencing.
- **Control plane** — GitOps repo layout, first-party reconciler design, console screens/roles/API, `ZDCloud` PowerShell module, end-to-end change flow.
- **Phases and runbooks**, **hardware and licensing**, **open questions** (Q1–Q12).
- Platform skeletons: Mills app spec and alerts, bucket set, gMSA inventory, environment pins, app schema rejecting inline secrets, console API `Program.cs`, `ZDCloud` module, IPsec identity rules, `sql-01` OpenTofu module, SF-node DSC.

### Changed
- **Platform base: Linux/Cozystack → Windows Server** (ADR-0002, owner decision). The 7 September Linux plan is preserved under `docs/adr/superseded/`.
- **Object storage: MinIO → SeaweedFS** (ADR-0007). MinIO community edition archived Feb 2026; commercial use without an AIStor licence is a legal exposure.
- **Cache: Redis/Valkey → Garnet** (ADR-0009). Valkey has no Windows build; Garnet is Microsoft-maintained and RESP-compatible.
- **Secrets: Vault → OpenBao** (ADR-0013). MPL-2.0, Linux Foundation, API-compatible.
- **Identity: Keycloak → Active Directory + AD FS** (ADR-0012). Keycloak would duplicate AD on Windows.
- **Scheduler: Kubernetes → Service Fabric guest executables** (ADR-0005); consequently **no container registry** (ADR-0006) and **no service mesh** (ADR-0015, IPsec instead).

### Fixed
- Commit `66a85df` was missing ten `platform/` files because the shell did not expand brace paths; added in `febbcb8` with identical content.

### Open
- ADR-0031 (return `umairv3_db` to FULL recovery) awaits the owner's ruling — see `docs/08-OPEN-QUESTIONS.md` Q7.
