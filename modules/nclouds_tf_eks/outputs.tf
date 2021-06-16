output "output" {
  value = {
    eks_cluster     = aws_eks_cluster.control_plane
    iam_role        = aws_iam_role.role
    iam_role_scaler = aws_iam_role.eks-autoscaler-role
  }
}
