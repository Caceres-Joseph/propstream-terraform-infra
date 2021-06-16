resource "random_integer" "cidr" {
  min = 10
  max = 172
}

module "vpc" {
  source = "./modules/nclouds_tf_vpc"
  name   = "propstream-${terraform.workspace}"
  cidr   = "${random_integer.cidr.result}.0.0.0/16"
}

module "worker_role" {
  source                 = "./modules/nclouds_tf_iam_role"
  iam_policies_to_attach = var.iam_policies_to_attach_worker
  aws_service_principal  = "ec2.amazonaws.com"
  identifier             = "${var.identifier}-${var.region}-worker"
  tags                   = var.tags
}

module "eks" {
  source             = "./modules/nclouds_tf_eks"
  security_group_ids = [module.eks_security_group.output.security_group.id]
  identifier         = "${var.identifier}-${var.region}"
  eks_version        = var.eks_version
  node_role_arn      = module.worker_role.output.role.arn
  node_min_size      = 1
  node_desired_size  = 1
  node_max_size      = 50
  node_instance_type = var.instance_type
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids  = module.vpc.public_subnets
  tags               = var.tags
}

module "eks_security_group" {
  source     = "./modules/nclouds_tf_security_group"
  identifier = "${var.identifier}-${terraform.workspace}-eks"
  vpc_id     = module.vpc.id
  tags       = var.tags
}

module "rds_security_group" {
  source     = "./modules/nclouds_tf_security_group"
  identifier = "${var.identifier}-${terraform.workspace}-rds"
  vpc_id     = module.vpc.id
  tags       = var.tags
}

module "rds" {
  source                     = "./modules/nclouds_tf_rds"
  rds_parameter_group_family = "postgres12"
  rds_engine_version         = "12.5"
  rds_instance_class         = var.db_instance_type
  security_groups            = [module.rds_security_group.output.security_group.id]
  identifier                 = var.identifier
  subnets                    = module.vpc.private_subnets
  vpc_id                     = module.vpc.id
  engine                     = "postgres"
  tags                       = var.tags
}
