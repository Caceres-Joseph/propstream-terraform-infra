data "tls_certificate" "cluster" {
  url = aws_eks_cluster.control_plane.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster.certificates.0.sha1_fingerprint]
  url = aws_eks_cluster.control_plane.identity.0.oidc.0.issuer
}

# ## OIDC config
# resource "aws_iam_openid_connect_provider" "cluster" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = ["3691b1a9efbe5f988b71860c39c61048a40b965f"]
#   url             = aws_eks_cluster.control_plane.identity.0.oidc.0.issuer
# }
#
#
# ### External cli kubergrunt
# data "external" "thumbprint" {
#   program = ["/bin/bash", "${path.module}/thumbprint.sh", data.aws_region.current.name]
# }
#
# data "aws_region" "current" {}
#
# data "aws_eks_cluster" "example" {
#   name = terraform.workspace
# }
#
# # New Data Source
# data "tls_remote_cert" "cluster_issuer" {
#   address = "${data.aws_eks_cluster.example.identity.0.oidc.0.issuer}"
#   # optional, for SNI if the endpoint is an IP
#   hostname = "${data.aws_eks_cluster.example.identity.0.oidc.0.issuer}"
#   # optional
#   port = 443
# }
#
# resource "aws_iam_openid_connect_provider" "example_cluster_issuer" {
#   url = "${data.aws_eks_cluster.example.identity.0.oidc.0.issuer}"
#
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#
#   thumbprint_list = [
#     "${data.tls_remote_cert.cluster_issuer.authority_chain.0.fingerprint}"
#   ]
# }
