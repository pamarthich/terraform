resource "aws_rds_cluster_instance" "instances" {
  count              = "1"
  identifier_prefix  = "test-cluster-"
  cluster_identifier = "${aws_rds_cluster.cluster.id}"
  instance_class     = "db.t2.medium"
  engine             = "aurora-mysql"
  engine_version     = "5.7.12"
}

#data "aws_availability_zones" "available" {}
resource "aws_rds_cluster_parameter_group" "parameter_group" {
  name        = "test-cluster"
  family      = "aurora-mysql5.7"
  description = "RDS default cluster parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "general_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "2"
  }
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier      = "test-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.12"
  availability_zones      = ["ap-south-1a", "ap-south-1b"]
  master_username         = "root"
  master_password         = "Cklass123ssalkC"
  backup_retention_period = "2"
  preferred_backup_window = "07:00-09:00"

  #vpc_security_group_ids          = ["${aws_security_group.database.id}"]
  #storage_encrypted               = true
  #db_subnet_group_name            = "${aws_db_subnet_group.database.name}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.parameter_group.id}"

  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
}
