Capistrano::Configuration.instance(:must_exist).load do
  
  namespace :symlink do
    desc "Creates a symlink to a shared/config/database.yml file"
    task :database, :roles => :db do
      run <<-CMD
        ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
      CMD
    end
    
    desc "Creates a symlink to non-versionned public files"
    task :public_files, :roles => :app do
      run <<-CMD
        ln -nfs #{shared_path}/public/files #{release_path}/public/files
      CMD
      run <<-CMD
        ln -nfs #{shared_path}/public/sitemap.xml #{release_path}/public/sitemap.xml
      CMD
      run <<-CMD
        ln -nfs #{shared_path}/public/robots.txt #{release_path}/public/robots.txt
      CMD
    end

    desc "Creates a symlink to a shared/config/initializers/site_keys.rb for restful_authentication"
    task :site_keys, :roles => :app do
      run <<-CMD
        ln -nfs #{shared_path}/config/initializers/site_keys.rb #{release_path}/config/initializers/site_keys.rb
      CMD
    end

    desc "Creates a symlink to a shared/config/initializers/paperclip.rb for Paperclip configuration (path etc)"
    task :paperclip, :roles => :app do
      run <<-CMD
        ln -nfs #{shared_path}/config/initializers/paperclip.rb #{release_path}/config/initializers/paperclip.rb
      CMD
    end
  end
  
  namespace :misc do
    desc "Clears git cached-copy, run before deploy when a submodule plugin changed"
    task :clear_cached_copy do
      run <<-CMD
        rm -rf #{shared_path}/cached-copy
      CMD
    end
  end
end