resource "aws_s3_bucket" "s3_caixadesapato" {
    bucket = "bucket-caixadesapato"

    tags = {
      Name = "s3 Projeto Caixa de Sapato"
    }
}

resource "aws_s3_bucket_policy" "allow_access" {
    bucket = aws_s3_bucket.s3_caixadesapato.id
    policy = data.aws_iam_policy_document.allow_access_bucket.json
}

data "aws_iam_policy_document" "allow_access_bucket" {
    statement {
        principals {
            type = "AWS"
            identifiers = ["810673762812"]
        }

        actions = [
            "s3:GetObject"
        ]

        resources = [ 
            aws_s3_bucket.s3_caixadesapato.arn,
            "${aws_s3_bucket.s3_caixadesapato.arn}/*"
        ]
    }
}