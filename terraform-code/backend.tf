terraform {
backend "s3" {
     bucket = "terraform-state-file-inno"
     key = "terraform"
   }
}
