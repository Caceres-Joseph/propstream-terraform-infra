variable "region" {
  description = "The region where the resources will be deployed"
  type        = string
  default     = "us-west-2"
}

variable "identifier" {
  description = "ID for all resources"
  default     = "propstream"
  type        = string
}

variable "iam_policies_to_attach_worker" {
  description = "List of ARNs of IAM policies to attach"
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  type = list(string)
}

variable "eks_version" {
  description = "eks version to use"
  default     = "1.20"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use"
  default     = "t3.medium"
  type        = string
}

variable "db_instance_type" {
  description = "DB Instance type to use"
  default     = "db.t3.large"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resource"
  default = {
    Origin = "terraform"
    Owner  = "nClouds"
  }
  type = map(any)
}
