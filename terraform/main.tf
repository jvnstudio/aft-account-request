# =============================================================================
# Mercy General Hospital - AWS Account Factory Demo
# =============================================================================
# Each module block represents a department/team AWS account.
# Push changes to this repo to trigger account creation via AFT pipeline.
# =============================================================================

# -----------------------------------------------------------------------------
# 1. IT Infrastructure - Core hospital IT systems and shared services
# -----------------------------------------------------------------------------
module "hospital_it_infrastructure" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-it@gmail.com"
    AccountName               = "MercyGen-IT-Infrastructure"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "John"
    SSOUserLastName           = "Nguyen"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "IT"
    CostCenter  = "IT-001"
    Compliance  = "HIPAA"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "John Nguyen"
    change_reason       = "Hospital demo - core IT infrastructure account"
  }
}

# -----------------------------------------------------------------------------
# 2. Electronic Health Records (EHR) - Patient data and clinical systems
# -----------------------------------------------------------------------------
module "hospital_ehr" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-ehr@gmail.com"
    AccountName               = "MercyGen-EHR-Systems"
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
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Sarah Chen"
    change_reason       = "Hospital demo - EHR and patient data systems"
  }
}

# -----------------------------------------------------------------------------
# 3. Medical Imaging (PACS/Radiology) - DICOM storage and imaging AI
# -----------------------------------------------------------------------------
module "hospital_imaging" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-imaging@gmail.com"
    AccountName               = "MercyGen-Medical-Imaging"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "David"
    SSOUserLastName           = "Park"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "Radiology"
    CostCenter  = "RAD-003"
    Compliance  = "HIPAA"
    DataClass   = "PHI"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "David Park"
    change_reason       = "Hospital demo - PACS and medical imaging storage"
  }
}

# -----------------------------------------------------------------------------
# 4. Billing & Revenue Cycle - Insurance claims, patient billing
# -----------------------------------------------------------------------------
module "hospital_billing" {
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
    CostCenter  = "FIN-004"
    Compliance  = "HIPAA-PCI"
    DataClass   = "PII-Financial"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Maria Rodriguez"
    change_reason       = "Hospital demo - billing and revenue cycle management"
  }
}

# -----------------------------------------------------------------------------
# 5. Lab & Pathology - Lab information systems, test results
# -----------------------------------------------------------------------------
module "hospital_lab" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-lab@gmail.com"
    AccountName               = "MercyGen-Lab-Pathology"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "James"
    SSOUserLastName           = "Williams"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "Laboratory"
    CostCenter  = "LAB-005"
    Compliance  = "HIPAA-CLIA"
    DataClass   = "PHI"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "James Williams"
    change_reason       = "Hospital demo - laboratory information systems"
  }
}

# -----------------------------------------------------------------------------
# 6. Pharmacy - Medication management, drug interaction systems
# -----------------------------------------------------------------------------
module "hospital_pharmacy" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-pharmacy@gmail.com"
    AccountName               = "MercyGen-Pharmacy"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Lisa"
    SSOUserLastName           = "Thompson"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "Pharmacy"
    CostCenter  = "RX-006"
    Compliance  = "HIPAA"
    DataClass   = "PHI"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Lisa Thompson"
    change_reason       = "Hospital demo - pharmacy management systems"
  }
}

# -----------------------------------------------------------------------------
# 7. HR & Workforce - Employee records, scheduling, credentialing
# -----------------------------------------------------------------------------
module "hospital_hr" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-hr@gmail.com"
    AccountName               = "MercyGen-HR-Workforce"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Michael"
    SSOUserLastName           = "Johnson"
  }

  account_tags = {
    Environment = "production"
    ManagedBy   = "AFT"
    Department  = "Human-Resources"
    CostCenter  = "HR-007"
    Compliance  = "HIPAA"
    DataClass   = "PII"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Michael Johnson"
    change_reason       = "Hospital demo - HR and workforce management"
  }
}

# -----------------------------------------------------------------------------
# 8. Research & Clinical Trials - De-identified data, research workloads
# -----------------------------------------------------------------------------
module "hospital_research" {
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
    Environment = "research"
    ManagedBy   = "AFT"
    Department  = "Research"
    CostCenter  = "RES-008"
    Compliance  = "HIPAA-IRB"
    DataClass   = "De-identified"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-research"

  change_management_parameters = {
    change_requested_by = "Emily Watson"
    change_reason       = "Hospital demo - clinical research and trials"
  }
}

# -----------------------------------------------------------------------------
# 9. Dev/Test - Development and testing environment (non-production)
# -----------------------------------------------------------------------------
module "hospital_devtest" {
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
    Environment = "development"
    ManagedBy   = "AFT"
    Department  = "IT"
    CostCenter  = "IT-009"
    Compliance  = "HIPAA"
    DataClass   = "Synthetic"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-dev"

  change_management_parameters = {
    change_requested_by = "Kevin Lee"
    change_reason       = "Hospital demo - development and testing environment"
  }
}

# -----------------------------------------------------------------------------
# 10. Disaster Recovery - Backup systems, business continuity
# -----------------------------------------------------------------------------
module "hospital_disaster_recovery" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+hospital-dr@gmail.com"
    AccountName               = "MercyGen-Disaster-Recovery"
    ManagedOrganizationalUnit = "Prod_ Workloads"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "Rachel"
    SSOUserLastName           = "Kim"
  }

  account_tags = {
    Environment = "dr"
    ManagedBy   = "AFT"
    Department  = "IT"
    CostCenter  = "IT-010"
    Compliance  = "HIPAA"
    DataClass   = "PHI-Backup"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "hospital-production"

  change_management_parameters = {
    change_requested_by = "Rachel Kim"
    change_reason       = "Hospital demo - disaster recovery and business continuity"
  }
}
