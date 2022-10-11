# terraform-gcp-node-pool-alert

This is an example of usage default Google metric called *instance_group* to track usage of nodes in autoscaling node-pool stack and trigger
a notification once max number of nodes available in autoscaling group per zone has been reached. 

Example was created because of google metrics not provided specific metric to track the number of nodes, and to implement this I decided to 
choose MQL alert type and a simple filter rule with a few dynamic variables in my project terraform code:

```
| metric 'compute.googleapis.com/instance_group/size'
| filter
    resource.instance_group_name
     =~ 'gke-${substr(var.cluster_name, 0, 16)}-${substr(var.machine_type, 0, 16)}-.*'
| group_by 1m, [value_size_mean: mean(value.size)]
| condition val() >= ${lookup(var.autoscaling, "max_node_count")}
| every 1m
```

Please pay attention on *substr* function in environment variables. 
It has been implemented here because a maximum characters number of Instance group is not more than *16*.

- Name of node-pools in my case was compiled with my GKE cluster name and desired machine's type in node-pool, so thats
 why I'm using *cluster_name & machine-type* variables in my code.