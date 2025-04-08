resource "aws_iam_role" "cluster"{
    name = "${var.cluster_name}-cluster-role"
 assume_role_policy = jsondecode(({
    Version = "2012-10-17"
    Statement = [
        "sts:AssumeRole",
        "sts: TagSession"
    ]
    Effect = "Allow"
    Principal = {
        Service = "eks.amazonaws.com"
    }
 }))   
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSCLusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.cluster.name
}

