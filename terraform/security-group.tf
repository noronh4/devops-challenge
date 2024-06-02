resource "aws_security_group" "lifters_sg_eks_worker" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id
}

# Allow inbound traffic from anywhere on all ports (This is a catch-all rule, be cautious with this in production environments)
resource "aws_security_group_rule" "lifters_sg_eks_worker_ingress_all" {
  description       = "allow inbound traffic from anywhere on all ports"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  security_group_id = aws_security_group.lifters_sg_eks_worker.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "lifters_sg_eks_worker_http_ingress" {
  description       = "allow inbound HTTP traffic on port 80"
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  security_group_id = aws_security_group.lifters_sg_eks_worker.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lifters_sg_eks_worker_liftes_app_ingress" {
  description       = "allow inbound HTTP traffic on port 8080"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  security_group_id = aws_security_group.lifters_sg_eks_worker.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lifters_sg_eks_worker_nodeport_ingress" {
  description       = "allow inbound traffic on NodePort range 30000-32767"
  from_port         = 30000
  protocol          = "tcp"
  to_port           = 32767
  security_group_id = aws_security_group.lifters_sg_eks_worker.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow outbound traffic to anywhere on all ports
resource "aws_security_group_rule" "lifters_sg_eks_worker_egress" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.lifters_sg_eks_worker.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
