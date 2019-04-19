resource "aws_db_parameter_group" "mariadb-parameters" {
    name = "mariadb-parameters"
    family = "mariadb10.1"
    description = "tets db cluster"
    parameter {
        name = "max_allowed_packet"
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

resource "aws_db_instance" "mariadb" {
    allocated_storage = 20
    engine = "mariadb"
    engine_version = "10.1.14"
    instance_class = "db.t2.micro"
    identifier = "mariadb"
    name = "mariadb1"
    username = "root"
    password = "Cklass11213ssalkC"
    parameter_group_name = "mariadb-parameters"  
    enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
}
