require 'capistrano/ext/multistage'

set :application, "asiafan"

set :scm, :git
set :repository, "https://github.com/dev-david/tclone.git"
set :scm_passphrase, ""
set :user, ""

set :stages, ["staging", "production"]
set :default_stage, "staging"
