# Terraform Directory

This directory houses the infrastructure-as-code for the Ultranav architecture. The goal is to keep environment provisioning consistent, auditable, and reproducible across cloud accounts and stages.

## Project Overview

- Declarative IaC: Terraform modules define networking, compute, and supporting services so changes are code-reviewed and versioned.
- Remote state: Uses a shared backend with locking to prevent concurrent applies from corrupting state.
- Modular design: Common building blocks live under `module/` and are composed by environment stacks.

## Structure

- `backend/`: Remote backend configuration for storing Terraform state.
- `module/`: Core reusable modules referenced by environment stacks.
- `main.tf`: Entry point that wires modules, providers, and backends together.
- `variables.tf`: Input variables consumed by the modules.
- `output.tf`: Relevant outputs exposed after `terraform apply`.

## Usage

1. Install Terraform `>= 1.5`.
2. Initialize providers and modules from this directory:
   ```
   terraform init
   ```
3. Preview changes:
   ```
   terraform plan -var-file="env.tfvars"
   ```
4. Apply when ready:
   ```
   terraform apply -var-file="env.tfvars"
   ```

> Keep backend state locking enabled to avoid concurrent apply conflicts.

## Working With PRs and Conflict Resolution

- Open a unique branch per pull request. To duplicate an existing branch for a second PR, create a new branch from the same commit (e.g., `git checkout -b feature-pr-2 origin/feature-pr-1`) and push it separately.
- When Git reports merge conflicts, run `git merge origin/main`, edit the conflicting files to remove the `<<<<<<<` markers, stage (`git add`) and continue the merge (`git merge --continue`).

See your project workflow documentation for detailed Git branching guidance.
