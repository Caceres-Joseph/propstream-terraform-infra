variable "identifier" {
  description = "The name for the cluster"
  type        = string
}

variable "eks_version" {
  description = "Desired Kubernetes master version"
  default     = "1.15"
  type        = string
}

variable "eks_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS API server is public"
  default     = true
  type        = bool
}

variable "public_access_cidrs" {
  description = "Indicates which CIDR blocks can access the Amazon EKS API server endpoint"
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to allow communication between your worker nodes and the Kubernetes control plane"
  default     = []
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs. Must be in at least two different availability zones"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs. Must be in at least two different availability zones"
}

variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map
}

variable "node_role_arn" {
  description = "Role arn to attach to the nodes"
  type        = string
}

variable "node_instance_type" {
  description = "Instance type of the worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_min_size" {
  description = "Minimum amount of nodes"
  default     = 1
  type        = number
}

variable "node_max_size" {
  description = "Maximum amount of nodes"
  default     = 3
  type        = number
}

variable "node_desired_size" {
  description = "Desired amount of nodes"
  default     = 2
  type        = number
}
