## Homebrew Apache2

#### Super Simple Installation

- `brew tap jaswsinc/homebrew-apache2`
- `brew install apache24`

*Apache is now installed with all modules enabled :-)*

#### Post Installation

After installation is complete, Homebrew will ask you to create a symlink in `~/Library/LaunchAgents`. Please **ignore this**, because it does NOT work properly with Apache. Apache needs to be started first as root; so creating a new agent won't do anything for you.

Thus, instead of `ln -sfv /usr/local/opt/apache24/*.plist ~/Library/LaunchAgents`

**Please use the following command to get this part right...**

```
sudo cp /usr/local/opt/apache24/*.plist /Library/LaunchDaemons
```

Now, start Apache for the first time without needing to reboot.

```
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.apache24.plist
```

## Adding PHP to Apache?

Be sure to add `--homebrew-apxs` as follows...

```
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap josegonzalez/homebrew-php
brew install php56 --with-homebrew-curl --with-homebrew-openssl --homebrew-apxs
```

*PHP is now installed and a `LoadModule php5_module` has already been added to `httpd.conf` for you. Don't forget to restart Apache so it picks up your new installation of PHP. See instructions below for details.*

For further details regarding PHP, see: <https://github.com/josegonzalez/homebrew-php>

## Start/Stop/Restart Apache?

Mac OS X comes with a built-in copy of Apache, so typing `sudo apachectl start` from the command line is NOT going to startup our Homebrew installation of Apache, it will startup the default/built-in (i.e. older) copy of Apache that comes with OS X.

##### There are two ways to avoid this problem.

1. Use the full path to `apachectl`; e.g. `sudo /usr/local/sbin/apachectl start`
2. Or, make life easier and modify your `$PATH` by adding the following lines to your `~/.profile`

```
# Give `/usr/local/sbin` a higher priority.
if [ -d /usr/local/sbin ]; then
    export PATH='/usr/local/sbin:'"$PATH";
fi;

# Give `/usr/local/bin` a higher priority.
if [ -d /usr/local/bin ]; then
    export PATH='/usr/local/bin:'"$PATH";
fi;
```

Now you can simply type: `sudo apachectl start` or `sudo apachectl stop` or `sudo apachectl restart`

## Adding MySQL for use with PHP?

```
brew install mysql
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
```

Then type the following command and choose `Y` (uppercase) for all questions.
```
mysql_secure_installation
```

----

*SEO: homebrew apache, homebrew apache24, homebrew apache 2.4, homebrew httpd, homebrew httpd24*  
*SEO: homebrew php, homebrew mysql, homebrew amp, homebrew lamp, homebrew mamp*
