server '3.21.59.95', user: 'sample_user', roles: %w{app db web}
#serverのIPアドレスと、ログイン可能なuser名を記載してください


set :ssh_options, {
  keys: %w(~/.ssh/sample_app_key_rsa), #秘密キーのpathを記載
  forward_agent: true,
  auth_methods: %w(publickey),
  port: 22
}
