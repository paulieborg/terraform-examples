
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| azs |  | `<list>` | no |
| db_port |  | `1433` | no |
| flow_log_retention |  | `60` | no |
| flow_log_traffic_type |  | `ALL` | no |
| log_forwarder_port |  | `9997` | no |
| region |  | `ap-southeast-2` | no |
| service |  | - | yes |
| subnet_start | The CIDR subnet number to start counting at. For each AZ the number is incremented by 1 from this number. | `1` | no |
| three_tier |  | `true` | no |
| vpc_cidr |  | `192.168.0.0/16` | no |

## Outputs

| Name | Description |
|------|-------------|
| app_1_subnet_ids |  |
| app_2_subnet_ids |  |
| db_subnet_ids |  |
| elb_subnet_ids |  |
| internet_gateway_id |  |
| vpc_id |  |

