# General VARS
cluster_name    = "my-cluster"                                                                # GKE cluster name
region          = "europe-west1"                                                              # Region
zone            = "europe-west1-b"                                                            # Zone ID
project         = "my-project-id"                                                             # Project ID
notification_channel = "projects/my-project-id/notificationChannels/notification-channels-id" # Id of your existing notification channel in Google Alerts

# Cluster Node Pool
machine_type        = "e2-custom-12-32768" # Type of VM machines in Node Pool
autoscaling = {                            # Auto-scaling policy with min and max node count per zone in Node Pool
  min_node_count = 0
  max_node_count = "20"
}
