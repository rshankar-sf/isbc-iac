resource "aws_autoscaling_schedule" "scale_down_weekends" {
  scheduled_action_name  = "scale_down_weekends"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  time_zone              = "Asia/Calcutta"
  start_time             = "2023-11-12T00:00:00Z"
  recurrence             = "0 0 * * 6-0"  # Every Saturday at 12:00 AM to Monday morning at 8:00 AM
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[0]
}

resource "aws_autoscaling_schedule" "scale_down_weekdays_night" {
  scheduled_action_name  = "scale_down_weekdays_night"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  time_zone              = "Asia/Calcutta"
  start_time             = "2023-11-13T00:00:00Z"
  recurrence             = "30 23 * * 1-5"  # From Monday to Friday, 11:30 PM to 8:00 AM
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[0]
}

resource "aws_autoscaling_schedule" "scale_up_weekdays" {
  scheduled_action_name  = "scale_up_weekdays"
  min_size               = 4  # Adjust this based on your desired number of instances
  max_size               = 10  # Adjust this based on your desired number of instances
  desired_capacity       = 4  # Adjust this based on your desired number of instances
  recurrence             = "0 8 * * 1-5"  # Every weekday at 8:00 AM
  start_time             = "2023-11-13T00:00:00Z"
  time_zone              = "Asia/Calcutta"
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[0]
}

