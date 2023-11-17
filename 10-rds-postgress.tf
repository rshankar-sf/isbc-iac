module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.customer_name}-${var.eks_environment}-sg"
  description = "Complete PostgreSQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = { name = "sg-${var.customer_name}-postgress-db"}
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "db-subnet_group"
  description = "Subnet Group for the RDS"

  subnet_ids = module.vpc.private_subnets
}

module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "isbc-db-postgres"
  engine         = "aurora-postgresql"
  engine_version = "14.5"
  instance_class = "db.t4g.medium"
  instances = {
    one = {}
    2 = {
      instance_class = "db.t4g.medium"
    }
  }

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  security_group_rules = {
    ex1_ingress = {
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10
  database_name       = "isbcdatabase"
  master_username           = "master"
  master_password           = "isbc@123"

  enabled_cloudwatch_logs_exports = ["postgresql"]
   backup_retention_period   = 1
   final_snapshot_identifier = "db-qa-postgress-snapshots"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}