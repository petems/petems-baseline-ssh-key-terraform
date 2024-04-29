# petems-baseline-ssh-key-terraform

A Terraform setup to create an SSH key. 

It also gives you an example config needed to put into your `.ssh/config` file:

```
$ terraform output github_ssh_configfile
Host fakeserver.example.xyz
  ControlMaster auto
  ControlPath ~/.ssh/ssh-%r@%h:%p
  ControlPersist yes
  IdentityFile ~/.ssh/github_ssh_key_08_Mar_2020
```

## Example

```shell
data.external.todays_date: Reading...
data.external.todays_date: Read complete after 0s [id=-]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.baseline_public_key_local will be created
  + resource "local_file" "baseline_public_key_local" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0600"
      + filename             = "/Users/petersouter/.ssh/coolkids_ssh_key_29_Apr_2024.pub"
      + id                   = (known after apply)
    }

  # local_sensitive_file.baseline_private_key_local will be created
  + resource "local_sensitive_file" "baseline_private_key_local" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0700"
      + file_permission      = "0600"
      + filename             = "/Users/petersouter/.ssh/coolkids_ssh_key_29_Apr_2024"
      + id                   = (known after apply)
    }

  # tls_private_key.baseline_key will be created
  + resource "tls_private_key" "baseline_key" {
      + algorithm                     = "ECDSA"
      + ecdsa_curve                   = "P384"
      + id                            = (known after apply)
      + private_key_openssh           = (sensitive value)
      + private_key_pem               = (sensitive value)
      + private_key_pem_pkcs8         = (sensitive value)
      + public_key_fingerprint_md5    = (known after apply)
      + public_key_fingerprint_sha256 = (known after apply)
      + public_key_openssh            = (known after apply)
      + public_key_pem                = (known after apply)
      + rsa_bits                      = 2048
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + baseline_ssh_configfile = <<-EOT
        Host fakeserver.example.xyz
          ControlMaster auto
          ControlPath ~/.ssh/ssh-%r@%h:%p
          ControlPersist yes
          IdentityFile ~/.ssh/coolkids_ssh_key_29_Apr_2024
    EOT
  + ssh_key_path            = "/Users/petersouter/.ssh/coolkids_ssh_key_29_Apr_2024"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tls_private_key.baseline_key: Creating...
tls_private_key.baseline_key: Creation complete after 0s [id=afa2ed27631d95ac61287e0f2615e4ef0845d9be]
local_sensitive_file.baseline_private_key_local: Creating...
local_file.baseline_public_key_local: Creating...
local_sensitive_file.baseline_private_key_local: Creation complete after 0s [id=ea4560b7cd7b2587c4d58d14f34e7ada5935b346]
local_file.baseline_public_key_local: Creation complete after 0s [id=11602ee9fc8b5180b31514173086391f5f8a39bc]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

baseline_ssh_configfile = <<EOT
Host fakeserver.example.xyz
  ControlMaster auto
  ControlPath ~/.ssh/ssh-%r@%h:%p
  ControlPersist yes
  IdentityFile ~/.ssh/coolkids_ssh_key_29_Apr_2024

EOT
ssh_key_path = "/Users/petersouter/.ssh/coolkids_ssh_key_29_Apr_2024"
```