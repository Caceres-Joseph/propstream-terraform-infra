# @see https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/
resource "aws_iam_role" "eks-autoscaler-role" {
  name       = "eks_autoscaler_role_${var.identifier}_${terraform.workspace}"
  depends_on = [aws_iam_role.role,aws_eks_node_group.node_group]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.role.arn}"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.cluster.arn}"
      }
    }
  ]
}
POLICY
}
#
# Set cluster autoscaller necessary policies
#
resource "aws_iam_role_policy" "eks-autoscaler-policy" {
  depends_on = [aws_iam_role.eks-autoscaler-role]
  name       = "eks_autoscaler_policy_${var.identifier}_${terraform.workspace}"
  role       = aws_iam_role.eks-autoscaler-role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
