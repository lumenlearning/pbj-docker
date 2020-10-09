# Purpose

Provide a local development environment for the Lumen PBJ application.

# Requirements

- Docker 17.03
- The candela repo cloned from Pantheon or from our github PBJ repo

If you are on a Mac, you will need to use the newer "Docker for Mac" instead of
"Docker Toolbox".

## Optional: Obtain the Pantheon repository URL

If you want to use the Pantheon PBJ repo log into Pantheon and obtain the repo URL for the environment you want to use Docker with (or use our github repo as noted in step 2).

Click:
1. Organizations
1. Lumen Learning
1. "Sites" tab
1. "candela" link
1. "Connection Info" button
1. Copy the "SSH clone URL" string

# Installation

## Step 1: Install Docker

You will need to download and install Docker.

- [https://www.docker.com/products/docker](https://www.docker.com/products/docker)

## Step 2: Clone the Pantheon candela repository

Clone the copied Pantheon repository or our local github repo (`https://github.com/lumenlearning/pbj`) to your laptop into `~/Sites/pbj`.

	$ git clone <repo_url> ~/Sites/pbj

Please note that if you use a cloned repo from Pantheon it is not connected to our repo `https://github.com/lumenlearning/pbj`. If you are introducing changes that need to go through PR review, you will want to use our github repo instead.

## Step 3: Build and start the PBJ development environment

Clone this directory locally. This repo will build the Docker images and containers used to build and run project.

	$ cd ~/pbj-docker
	$ ./start-everything.sh

The first time this command is used, it will take a while to complete. It will be downloading
several Debian packages for the various server-side dependencies required by PBJ.

If you need to stop your Docker session you can run `/.stop-everything.sh` or `./delete-everything.sh` to remove images. If something is truly borked running `docker kill $(docker ps -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)` will kill all containers and images. Then you would run `./start-everything.sh` to build from scratch.

## Step 4: Enjoy!

Your project files are now located in: `~/Sites/pbj`
	- Note: Your WP config will be updated in `wp-config-local.php` and that's where you can check out and tweak your local WP settings
Your database files are located in: `~/Sites/pbj-db`

Your Wordpress website is reachable at: [http://localhost:80/](http://localhost:80/) and it will take you through the Wordpress install (if the port is being tricky which sometimes happened to me at `8080` hitting `http://localhost/wp-admin` also does the trick).

If you need to connect directly to the database, it will be available at localhost:3307 (user `pbj`, password `pbj`).

## Step 5: Configure WP to mirror your Pantheon environment
To mirror the Pantheon environment and get plugins running you have to go through a few steps.

- After WP installation login with new account created
- Next we want to install Multisite which is required for Pressbooks. Unfortunately this isn't something that can be part of the Docker container as it requires WP as well as local tweaks.
- If you want to use a sub-domain-based multisite setup (like our production site does):
	- Edit your /etc/hosts to include the line: 127.0.0.1 pbj.local
	- Go to Settings > General and change the Wordpress Address and Site Address settings to http://pbj.local 
	- You'll need to remember to edit /etc/hosts every time you add a new Book.
	- Go to Tools > Network Setup in WP, choose Sub-domains, and click Install
- If you're fine using sub-directories instead:
	- Just go to Tools > Network Setup in WP and click Install
- Take note of correct settings for your WP install at ~/Sites/pbj
- Update your `wp-config-local.php` with the correct multisite values provided
- Update .htaccess file with correct values provided
- After updating if you refresh WP you may be booted out, once you log back in Multisite should be enabled (you can see this if you look in main menu and you have option to add a new site)
- Network Enable Pressbooks plugin from Plugin options (in Admin Dashboard > Plugins, and all plugins should already be there that we part of that Pantheon repo)
- For look and feel to be correct for PBJ you also want to Network Enable `Candela Utility` plugin. Now everything should _look_ the same in PBJ
- At this point you should be able to install whatever Plugins you want and all should work hopefully - you may want to do one by one as doing bulk install may error out as some plugins rely on others (such as LTI I believe)
- For book themes to be correct you should go to Themes in your admin Dashboard and Network Enable Pressbooks Publisher as the theme, and _then_ Network Enable Bombadil. Now for any books created you should be able to use the Bombadil theme and things will be looking prettay prettay good.
- With plugins and themes enabled now you should be able to add / import books and have things look the same between the local and Pantheon environment you cloned down
- Note: If you upgrade plugins things may change or break (this could be good if you are testing)

## Step 5: Potential Gotcha's
- When importing books into PBJ you may get an error that max file size in `php.ini` has been exceeded. This can be fixed by adding:
```
php_value upload_max_filesize 256M
```
To the `.htaccess` file in your local PBJ directory (`~/Sites/pbj`)
- Sometimes there is a switcheroo between `http` and `https` when navigating in PBJ - in those cases it can look like you're logged out but if you head to `localhost/wp-admin` it will usually do the trick. I think this will be fixed by our rewritting in the db of http to https links.
