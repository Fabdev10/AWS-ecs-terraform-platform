terraform {
  # Keeping backend coordinates outside versioned code makes it easier to promote the same root module across accounts.
  backend "s3" {}
}
