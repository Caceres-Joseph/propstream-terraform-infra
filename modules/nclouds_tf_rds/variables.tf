
variable "vpc_id" {
  description = "VPC id for the resources"
  type        = string
}

variable "security_groups" {
  description = "Security group"
  type        = list(string)
}

variable "subnets" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "rds_database_name" {
  description = "Name of the database"
  default     = "default_database"
  type        = string
}

variable "rds_master_username" {
  description = "Master username for the database"
  default     = "root"
  type        = string
}

variable "rds_instance_class" {
  description = "Instance class for the database"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Allocated storage"
  default     = 21
  type        = number
}

variable "rds_engine_version" {
  description = "Engine version for the db"
  type        = string
}

variable "rds_parameter_group_family" {
  description = "Parameter group family for the instance"
  type        = string
}

variable "multi_az" {
  description = "Set to 'true' to deploy the rds instance as multi-az"
  default     = false
  type        = bool
}

variable "backup_retention_period" {
  description = "Backup retention period"
  default     = 7
  type        = number
}

variable "storage_type" {
  description = "Storage type for the db"
  default     = "gp2"
  type        = string
}


variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed"
  default     = false
  type        = bool
}

variable "encryption" {
  description = "(Optional) Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN"
  default     = true
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = true
  type        = bool
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  default     = true
  type        = bool
}

variable "engine" {
  description = "Define the engine for the database"
  type        = string
}

variable "identifier" {
  description = "The name for the resources"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map
}

variable "password" {
  description = "RDS DB password. If not set, random password will be used and stored in SSM"
  default     = null
  type        = string
}