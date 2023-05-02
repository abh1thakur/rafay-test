resource "rafay_eks_cluster" "ekscluster-local" {
  cluster {
    kind = "Cluster"
    metadata {
      name    = "abhishek-gitops-test" # name of your cluster
      project = "abhishek-test" # project to be used for the cluster
    }
    spec {
      type              = "eks"
      blueprint         = "default"
      blueprint_version = "Latest"
      cloud_provider    = "" # Cloud Credentials, as mentioned in Rafay UI
      cni_provider      = "Calico-v3.24.5"
      proxy_config      = {}
    }
  }
  cluster_config {
    apiversion = "rafay.io/v1alpha5"
    kind       = "ClusterConfig"
    metadata {
      name    = "abhishek-terraform-test" # Should be same as your cluster name
      region  = "us-west-2"           # AWS region
      version = "1.22"                # Cluster k8s version
      tags = {}
    }
    vpc {
      cidr = "192.168.0.0/16"
      cluster_endpoints {
        private_access = true
        public_access  = false
      }
      nat {
        gateway = "Single"
      }
    }
    managed_nodegroups {
      name               = "managed-ng-1" # Node Group name
      ami_family         = "AmazonLinux2"
      iam {
          iam_node_group_with_addon_policies {
            image_builder = true
            auto_scaler   = true
            efs = true
          }
      }
      instance_type      = "t3.medium" # AWS instance type
      desired_capacity   = 1
      min_size           = 1
      max_size           = 1
      max_pods_per_node  = 50
      version            = "1.22"
      volume_size        = 20
      volume_type        = "gp3"
      volume_iops        = 3000
      volume_throughput  = 125
      private_networking = true
      tags = {}
    }
  }
}