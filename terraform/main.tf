# =============================================================================
# Mercy General Hospital - AWS Multi-Account Architecture
# =============================================================================
# 5 accounts, each with a distinct security boundary and compliance reason.
# OracleDB@AWS sits in Shared Services (hub). Spoke accounts connect via
# Transit Gateway over private endpoints. One git push, five accounts,
# HIPAA guardrails enforced automatically.
#
# Architecture:
#
#   [Shared Services]  ← Transit Gateway hub, OracleDB@AWS endpoint, DNS
#         |
#    ┌────┼────┬────────┐
#    |    |    |        |
#  [EHR] [Billing] [Research] [Dev/Test]
#
# Data flow:
#   Patient arrives → EHR writes clinical DB (Oracle)
#                   → Billing reads diagnosis codes (Oracle, separate schema)
#                   → Research gets de-identified extract (SCP blocks PHI)
#                   → Dev/Test uses synthetic data only (zero PHI)
# =============================================================================

# -----------------------------------------------------------------------------
# 1. Shared Services (Hub)
# -----------------------------------------------------------------------------
# WHY SEPARATE: This is the hub. Transit Gateway, OracleDB@AWS private
# endpoint, Route 53 private hosted zones, and centralized secrets all live
# here. No application workloads run in this account -- it only routes
# traffic and hosts the Oracle Exadata cluster endpoint.
#
# OracleDB@AWS databases hosted here:
#   - clinical_db   (EHR patient records, vitals, orders)
#   - financial_db  (billing, claims, revenue cycle)
#   - research_db   (de-identified extracts, IRB-approved datasets)
#   - hr_db         (employee records, credentialing, scheduling)
#   - devtest_db    (synthetic data, no PHI)
# -----------------------------------------------------------------------------
module "shared_services" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-shared@gmail.com"
    AccountName               = "MercyGen-Shared-Services"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "John"
    SSOUserLastName           = "Nguyen"
  }

  account_tags = {
    Environment  = "production"
    ManagedBy    = "AFT"
    Department   = "Infrastructure"
    CostCenter   = "INFRA-001"
    Compliance   = "HIPAA"
    AccountRole  = "hub"
    OracleDBAtAWS = "true"
    Owner        = "jvnstudio"
  }

  account_customizations_name = "hospital-shared-services"

  change_management_parameters = {
    change_requested_by = "John Nguyen"
    change_reason       = "Hub account - Transit Gateway, OracleDB@AWS endpoint, centralized DNS and secrets"
  }
}

# -----------------------------------------------------------------------------
# 2. Electronic Health Records (EHR)
# -----------------------------------------------------------------------------
# WHY SEPARATE: Strictest HIPAA controls. Contains PHI -- patient records,
# vitals, medication orders, clinical notes. SCPs block all internet egress,
# public S3, and unencrypted volumes. ECS app tier connects to clinical_db
# in the hub via Transit Gateway on port 1522. This account can ONLY reach
# its own Oracle schema (clinical.*) -- cannot query financial or HR data.
# -----------------------------------------------------------------------------
module "ehr_clinical" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-ehr@gmail.com"
    AccountName               = "MercyGen-EHR-Clinical"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Sarah"
    SSOUserLastName           = "Chen"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "Clinical-Systems"
    CostCenter  = "CS-002"
    Compliance  = "HIPAA"
    DataClass   = "PHI"
    AccountRole = "spoke"
    OracleSchema = "clinical"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Sarah Chen"
    change_reason       = "EHR account - patient records, clinical systems, strictest PHI controls"
  }
}

# -----------------------------------------------------------------------------
# 3. Billing & Revenue Cycle
# -----------------------------------------------------------------------------
# WHY SEPARATE: Handles PII + financial data (PCI + HIPAA). Insurance claims,
# patient billing, EOBs, EDI transactions. Needs to read diagnosis codes
# from Oracle but through its OWN schema (financial.*) -- cannot query
# clinical notes or HR records. S3 stores scanned claim documents, signed
# PDFs, and EDI archives. Separate account because a billing clerk should
# never be able to query patient clinical records.
# -----------------------------------------------------------------------------
module "billing" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-billing@gmail.com"
    AccountName               = "MercyGen-Billing"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Maria"
    SSOUserLastName           = "Rodriguez"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "Finance"
    CostCenter  = "FIN-003"
    Compliance  = "HIPAA-PCI"
    DataClass   = "PII-Financial"
    AccountRole = "spoke"
    OracleSchema = "financial"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Maria Rodriguez"
    change_reason       = "Billing account - revenue cycle, claims processing, PCI + HIPAA financial isolation"
  }
}

# -----------------------------------------------------------------------------
# 4. Research & Clinical Trials
# -----------------------------------------------------------------------------
# WHY SEPARATE: This is the account that proves the architecture works.
# SCP explicitly DENIES any resource tagged DataClass=PHI. Researchers
# can only access de-identified datasets in the research_db schema.
# If someone tries to copy PHI into this account, the SCP blocks it.
# This is how you pass a HIPAA audit for research -- prove that PHI
# physically cannot enter the research environment.
# -----------------------------------------------------------------------------
module "research" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-research@gmail.com"
    AccountName               = "MercyGen-Research"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Emily"
    SSOUserLastName           = "Watson"
  }

  account_tags = {
    Environment  = "research"
    ManagedBy    = "AFT"
    Department   = "Research"
    CostCenter   = "RES-004"
    Compliance   = "HIPAA-IRB"
    DataClass    = "De-identified"
    AccountRole  = "spoke"
    OracleSchema = "research"
    Owner        = "jvnstudio"
  }

  account_customizations_name = "hospital-research"

  change_management_parameters = {
    change_requested_by = "Emily Watson"
    change_reason       = "Research account - de-identified data only, SCP blocks PHI, IRB-approved workloads"
  }
}

# -----------------------------------------------------------------------------
# 5. Dev/Test
# -----------------------------------------------------------------------------
# WHY SEPARATE: Developers need freedom to break things without risk to
# production PHI. This account uses ONLY synthetic patient data -- generated,
# not copied from production. SCPs enforce cost controls (no large instances,
# no reserved capacity). Broader IAM permissions so devs can experiment,
# but zero access to production Oracle schemas or S3 buckets.
# -----------------------------------------------------------------------------
module "devtest" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-devtest@gmail.com"
    AccountName               = "MercyGen-DevTest"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Kevin"
    SSOUserLastName           = "Lee"
  }

  account_tags = {
    Environment  = "development"
    ManagedBy    = "AFT"
    Department   = "Engineering"
    CostCenter   = "ENG-005"
    Compliance   = "HIPAA"
    DataClass    = "Synthetic"
    AccountRole  = "spoke"
    OracleSchema = "devtest"
    Owner        = "jvnstudio"
  }

  account_customizations_name = "hospital-dev"

  change_management_parameters = {
    change_requested_by = "Kevin Lee"
    change_reason       = "Dev/Test account - synthetic data only, cost controls, zero PHI access"
  }
}
