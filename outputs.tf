output "output" {
  value = {
    eks_name        = module.eks.output.eks_cluster.name
    env             = module.eks.output.eks_cluster.id
    autoscaler_role = module.eks.output.iam_role_scaler.arn
    worker_role     = module.worker_role.output.role.arn
  }
}
