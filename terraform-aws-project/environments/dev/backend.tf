terraform {
  # The backend is intentionally partial because production teams usually keep bucket names and lock table names outside reusable code.
  backend "s3" {}
}
