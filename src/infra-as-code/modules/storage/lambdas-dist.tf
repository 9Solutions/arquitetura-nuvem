resource "aws_s3_object" "s3_dist_pdf" {
    bucket = aws_s3_bucket.s3_caixadesapato.id
    key = "dist_pdf.zip"
    source = "dists/dist-pdf.zip"
}