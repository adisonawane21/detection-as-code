# Detection-as-Code Pipeline

A CI/CD pipeline for Sigma detection rules. Validates rules on push, converts them to Microsoft Sentinel KQL and Google SecOps UDM, and scans Terraform configuration for security misconfigurations.

## How it works

On every push to main, GitHub Actions runs three jobs:

1. Sigma validation - runs sigma check on all rules in sigma/
2. IaC security - runs Checkov against terraform/
3. Sigma conversion - converts each rule to KQL and UDM, uploads the output as a build artifact

If validation or Checkov fails, the pipeline fails. The conversion job runs after the other two pass.

## Repository layout

    sigma/                      Source Sigma rules
    queries/kql/                Converted Microsoft Sentinel queries
    queries/udm/                Converted Google SecOps queries
    terraform/hardened_s3/      Sample hardened S3 configuration
    docs/                       Design notes
    .github/workflows/          CI pipeline definition

## Rules included

| Rule | Platform | ATT&CK |
|---|---|---|
| PowerShell encoded command | Windows | T1059.001 |
| Suspicious S3 configuration (Terraform) | AWS | - |

The S3 rule is enforced through Checkov rather than Sigma, since it's a configuration check rather than runtime telemetry.

## Running locally

Install dependencies:

    pip install sigma-cli pysigma-backend-kusto pysigma-backend-secops

Validate all rules:

    sigma check sigma/

Convert a single rule to KQL:

    sigma convert -t kusto -p sentinel_asim sigma/powershell_suspicious.yml

Convert a single rule to UDM:

    sigma convert -t secops -p secops_udm sigma/powershell_suspicious.yml

## Design notes

See docs/design.md for the reasoning behind the pipeline structure and the choice of Sigma as the source format.