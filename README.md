# ZD Cloud

**Zaraat Dost's sovereign, Windows-first private cloud.** The plan, the decisions, the map, and the control plane for replacing AWS with hardware we own.

| | |
|---|---|
| Owner | Adil Munawar, ML Research & Development |
| Status | Planning · v0.1.0 · 8 September 2026 |
| Base | Windows Server 2025 Datacenter · Hyper-V · Failover Clustering · Storage Spaces Direct · Service Fabric · Active Directory |
| Exceptions | One Linux GPU node · one Linux VM for the Wazuh SIEM manager · OPNsense edge appliances |
| Control | Web console (custom, .NET 10 + Next.js) · PowerShell/`zdc` CLI · GitOps repo as the single source of truth |

## Start here

1. [`docs/00-MASTER-PLAN.md`](docs/00-MASTER-PLAN.md) — what we are building, the targets, the phases.
2. [`docs/01-DECISIONS.md`](docs/01-DECISIONS.md) — **why** every component was chosen, what it replaces, what was rejected. Every future change to the platform starts as a new ADR here.
3. [`docs/02-APPLICATION-INFRASTRUCTURE-MAP.md`](docs/02-APPLICATION-INFRASTRUCTURE-MAP.md) — every application, down to the service account, bucket, port and backup that carries it.
4. [`docs/03-SECURITY-ARCHITECTURE.md`](docs/03-SECURITY-ARCHITECTURE.md) — the controls, the threat model, the evidence.
5. [`docs/04-NETWORK-AND-SITES.md`](docs/04-NETWORK-AND-SITES.md) — zones, VLANs, addressing, the two sites.
6. [`docs/05-CONTROL-PLANE.md`](docs/05-CONTROL-PLANE.md) — the console, the CLI, the GitOps flow.
7. [`docs/06-PHASES-AND-RUNBOOKS.md`](docs/06-PHASES-AND-RUNBOOKS.md) — the schedule with exit gates; `docs/runbooks/` for the operational procedures.
8. [`docs/07-HARDWARE-AND-LICENSING.md`](docs/07-HARDWARE-AND-LICENSING.md) — bill of materials, Windows and SQL licensing.
9. [`docs/08-OPEN-QUESTIONS.md`](docs/08-OPEN-QUESTIONS.md) — decisions still needed from the owner.

## Repository layout

```
docs/               the plan (read these first)
docs/adr/           one file per architecture decision, numbered
docs/runbooks/      operational procedures — one per failure or task
platform/console/   ZD Cloud Console (.NET 10 API + Next.js) — the web control surface
platform/cli/       ZDCloud PowerShell module + zdc thin CLI
platform/gitops/    desired state of the platform: apps, VMs, buckets, secrets refs, policies
platform/policies/  WDAC, GPO baselines, firewall/IPsec, Wazuh rules — enforced, versioned
platform/iac/       OpenTofu (Hyper-V provider) + DSC v3 for hosts and VMs
CHANGELOG.md        every change to the plan, dated, with the reason
```

## How changes happen

Nothing about this platform changes without a commit here. A new component, a removed one, a changed port, a rotated key policy: it is an ADR (`docs/adr/`), a line in `CHANGELOG.md`, and a change in `platform/`. `git log` is the history of why the platform is the way it is.

## Relationship to other repos

- `Zarz001/Mills-Restructured-by-Zayan` — the first application to land on the platform (Phase 2).
- `adilmunawar/ZD-claude-plugin` — the team's Claude Code plugins; `zd-deploy`, `zd-ops` and `zd-security` are pointed at `platform/gitops/` and `docs/runbooks/`.
- `Adilmunawar/ZaraatDost-Models`, `AdilMunawar/sugarcane` — the ML pipelines that move to the GPU node in Phase 3.
