# Detection-as-Code Pipeline

A CI/CD pipeline that validates Sigma detection rules and converts them to SIEM queries (KQL, UDM) automatically on every push.

## Status

- In Progress

## What This Does

- Validates Sigma rules for syntax and best practices
- Converts rules to KQL (Microsoft Sentinel) and UDM (Google SecOps)
- Scans Terraform configurations for security misconfigurations

## Tools Used

- sigma-cli (rule validation and conversion)
- GitHub Actions (CI/CD)
- Checkov (IaC security scanning)