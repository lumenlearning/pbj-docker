# Purpose

Provide a local development environment for the Lumen PBJ application.

# Requirements

- Docker 17.03
- The candela repo cloned from Pantheon

If you are on a Mac, you will need to use the newer "Docker for Mac" instead of
"Docker Toolbox".

## Obtaining the Pantheon repository URL

Log into Pantheon and obtain the repo URL for PBJ.

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

Clone the repository to your laptop to `~/Sites/pbj` (likely want to tweak the copied Github clone URL to copy the repo here as opposed to `candela`).

	$ git clone <repo_url> ~/Sites/pbj

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
	- Go to Tools > Network Setup in WP and click Install
	- Take note of correct settings for your WP install at ~/Sites/pbj
	- Update your `wp-config-local.php` with the correct multisite values provided
	- Update .htaccess file with correct values provided
	- After updating if you refresh WP you may be booted out, once you log back in Multisite should be enabled (you can see this if you look in main menu and you have option to add a new site)
- Install Pressbooks plugin from Plugin options (in Admin Dashboard > Plugins, and all plugins should already be there that we part of that Pantheon repo)
- For look and feel to be correct for PBJ you also want to install `Candela Utility` plugin. Now everything should _look_ the same in PBJ
- At this point you should be able to install whatever Plugins you want and all should work hopefully - you may want to do one by one as doing bulk install may error out as some plugins rely on others (such as LTI I believe)
- For book themes to be correct you should go to Themes in your admin Dashboard and enable Pressbooks Publisher as the theme, and _then_ enable Bombadil (you may want to enable Luther as well as that is what Bombadil is built off), but pretty sure this isn't necessary). Now for any books created you should be able to use the Bombadil theme and things will be looking prettay prettay good.
- With plugins and themes enabled now you should be able to add / import books and have things look the same between the local and Pantheon environment you cloned down
- Note: If you upgrade plugins things may change or break (this could be good if you are testing)

