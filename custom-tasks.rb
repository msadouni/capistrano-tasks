Capistrano.configuration(:must_exist).load do
  
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
  end
  
  namespace :misc
    desc "Clears git cached-copy, run before deploy when a submodule plugin changed"
    task :clear_cached_copy do
      run <<-CMD
        rm -rf #{shared_path}/cached-copy
      CMD
    end
  end
end