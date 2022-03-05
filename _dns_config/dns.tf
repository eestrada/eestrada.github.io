terraform {
  required_providers {
    namecheap = {
      source  = "namecheap/namecheap"
      version = ">= 2.0.0"
    }
  }
}

# Namecheap API credentials
provider "namecheap" {
  # user_name = "user"  # use envar `NAMECHEAP_USER_NAME` to maintain secrets.
  # api_user = "user"   # use envar `NAMECHEAP_API_USER` to maintain secrets.
  # api_key = "key"     # use envar `NAMECHEAP_API_KEY` to maintain secrets.
  # client_ip = "123.123.123.123"
  use_sandbox = false
}

# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

resource "namecheap_domain_records" "misterfidget-com" {
  domain     = "misterfidget.com"
  mode       = "MERGE"
  email_type = "FWD"


  # Regular email
  record {
    hostname = "@"
    type     = "TXT"
    address  = "v=spf1 include:mailgun.org ~all"
    ttl      = 300
  }


  record {
    hostname = "emailytics"
    type     = "CNAME"
    address  = "mailgun.org."
  }

  record {
    hostname = "krs._domainkey"
    type     = "TXT"
    address  = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDvy07hStX5dagz9sjuWXpsIypps1gQYerdZNKv6I3uJ4VkERYv+m6+nvgamhjOtcAT4xRHTtrBv7la3PzsOAhPrwhgKoobBw7vG6kBtSXsOtLkcwrjtxoPgPuKm+7inDBxD07i54N0r/PlSSFolJ3BCy7kRn9U7xuhq+SuVMxfDwIDAQAB"
    ttl      = 300
  }

  # Github pages website hosting
  record {
    hostname = "www"
    type     = "CNAME"
    address  = "eestrada.github.io."
  }

  record {
    hostname = "@"
    type     = "ALIAS"
    address  = "eestrada.github.io."
  }

  # Keybase verification
  record {
    hostname = "@"
    type     = "TXT"
    address  = "keybase-site-verification=nxDZFGyYQbwa6adLGTNQf9itfXg5oeIhXKQErsrlnM8"
    ttl      = 300
  }
}
