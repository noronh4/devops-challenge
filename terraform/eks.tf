module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "lifters-eks-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true

  depends_on = [
    module.vpc,
    aws_security_group.lifters_sg_eks_worker
  ]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   =  module.vpc.vpc_id
  subnet_ids               =  module.vpc.private_subnets
  control_plane_subnet_ids =  module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.small"]
    vpc_security_group_ids = [aws_security_group.lifters_sg_eks_worker.id]
  }

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 2
      desired_size = 2

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    access_entries-root = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::339713063030:root"

      policy_associations = {
        policy_associations-root = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  }


  tags = {
    Terraform   = "true"
  }
}

