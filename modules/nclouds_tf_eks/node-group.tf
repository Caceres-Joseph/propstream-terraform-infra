resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.control_plane.name
  node_group_name = "${var.identifier}-${terraform.workspace}"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = [var.node_instance_type]

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = tomap({
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.control_plane.name}" = "owned",
    "k8s.io/cluster-autoscaler/enabled" = true
  })

}
