resource "google_monitoring_alert_policy" "alert_main_node_pool_group_reached_man_number_of_nodes" {
  display_name = "[${var.cluster_name}] Max number of Nodes in instance group is reached - ${var.machine_type}"
  project      = var.project
  notification_channels = [
    var.notification_channel,
  ]
  combiner     = "OR"
  documentation {
    content   = <<EOT
Maximum number of nodes has been reached in node-pool!

- Cluster: ${var.cluster_name}
- Node-Pool: ${var.machine_type}
- State: nodes number is >= ${lookup(var.autoscaling, "max_node_count")} per zone
- Notes: maximum available number of nodes per zone is: ${lookup(var.autoscaling, "max_node_count")}
EOT
    mime_type = "text/markdown"
  }
  conditions {
    display_name = "[${var.cluster_name}] Max number of Nodes in instance group is reached - ${var.machine_type}"
    condition_monitoring_query_language {
      query = <<EOT
fetch instance_group
| metric 'compute.googleapis.com/instance_group/size'
| filter
    resource.instance_group_name
     =~ 'gke-${substr(var.cluster_name, 0, 16)}-${substr(var.machine_type, 0, 16)}-.*'
| group_by 1m, [value_size_mean: mean(value.size)]
| condition val() >= ${lookup(var.autoscaling, "max_node_count")}
| every 1m
EOT
      duration = "60s"
    }
  }
}