# Init script for WordPress trunk site
DEVSITE="abletest5"
EMAIL="pete@ablewild.com"
DBNAME="wordpress_$DEVSITE"
DEVURL="local.$DEVSITE.dev"

# Create a working directory for the new devsite
mkdir $DEVSITE
cd $DEVSITE

echo $DEVURL > vvv-hosts

cat > vvv-nginx.conf <<endmsg
server {
    # Listen at port 80 for HTTP requests
    listen          80;
    # Listen at port 443 for secure HTTPS requests
    listen          443 ssl;
    # The domain name(s) that the site should answer
    # for. You can use a wildcard here, e.g. 
    # *.example.com for a subdomain multisite.
    server_name     $DEVURL;

    # The folder containing your site files.
    # The {vvv_path_to_folder} token gets replaced 
    # with the folder containing this, e.g. if this
    # folder is /srv/www/foo/ and you have a root
    # value of `{vvv_path_to_folder}/htdocs` this 
    # will be auto-magically transformed to
    # `/srv/www/foo/htdocs`.
    root            {vvv_path_to_folder}/htdocs;

    # A handy set of common Nginx configuration commands
    # for WordPress, maintained by the VVV project.
    include         /etc/nginx/nginx-wp-common.conf;
}
endmsg

echo "Commencing WordPress $DEVSITE devsite install"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS $DBNAME"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO wp@localhost IDENTIFIED BY 'wp';"


# Check for the presence of a `htdocs` folder.
if [ ! -d htdocs ]
then
    echo "Getting latest version of Wordpress"
    # If `htdocs` folder doesn't exist, download latest version of WP
    wget http://wordpress.org/latest.tar.gz
    # Unarchive it
    tar xfz latest.tar.gz
    # Create an htdocs folder
    mkdir htdocs
    # Move the Wordpress files into it
    mv wordpress/* ./htdocs
    # Remove junk
    rmdir ./wordpress/
    rm -f latest.tar.gz
    rm -rf ./htdocs/wp-content/plugins/akismet/
    rm ./htdocs/wp-content/plugins/hello.php
    #rm -rf ./htdocs/wp-content/themes/twenty*

    # Install CX plugins
    git clone https://github.com/clarkcx/cx_contactdeets.git ./htdocs/wp-content/plugins/cx_contactdeets
    git clone https://github.com/clarkcx/cx_shortcodes.git ./htdocs/wp-content/plugins/cx_shortcodes
    git clone https://github.com/clarkcx/cx_services.git ./htdocs/wp-content/plugins/cx_services
    
    # Change into the `htdocs` folder
    cd htdocs
    # Use WP CLI to create a `wp-config.php` file
    wp core config --dbname="$DBNAME" --dbuser=wp --dbpass=wp --dbhost="localhost" --allow-root
    # Use WP CLI to install WordPress
    wp core install --url=local.$DEVSITE.dev --title="$DEVSITE" --admin_user=admin --admin_password=password --admin_email=$EMAIL --allow-root
    # Change folder to the parent folder of `htdocs`
    cd ..
else
    echo "Looks like you already have this installed"
fi

# The Vagrant site setup script will restart Nginx for us

# Let the user know the good news
echo "$DBNAME created and $DEVSITE installed. Yo.";
