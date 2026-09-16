# Design Notes

## Why Sigma

Detection rules written directly in a SIEM query language are locked to that platform. A rule written for Splunk needs to be rewritten for Sentinel, and rewritten again for Chronicle. Sigma is a vendor-neutral format that compiles to any of them.

Writing in Sigma means the source of truth is one file, and the platform-specific queries are build artifacts. When a rule changes, the change happens in one place.

## Why CI/CD

Detection rules are code. They should be reviewed, validated, and deployed the same way application code is. Without automation:

- Rules are edited directly in a SIEM UI with no version history
- Broken rules are discovered when they fail in production
- Nobody knows who changed a rule or why
- Testing is manual and inconsistent

The pipeline here enforces the basics: syntax validation on every push, automatic conversion to both target platforms, and IaC security checks in the same workflow.

## Why Checkov alongside Sigma

Sigma covers runtime detections - activity observed in telemetry. Checkov covers configuration - how infrastructure is defined. Both matter for a security posture, and both benefit from being validated in CI rather than discovered later.

Putting them in the same pipeline means a single push validates both the detection logic and the infrastructure it will run against.

## Scope and limitations

This project is a working demonstration, not a production system. It does not include:

- Rule testing against real telemetry (would require sample logs and a test harness)
- Deployment to a live SIEM (would require platform credentials)
- Peer review enforcement (would require branch protection rules and CODEOWNERS)

The structure is deliberately minimal so the core idea - validate, convert, enforce - is visible without infrastructure overhead.