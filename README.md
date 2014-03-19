## Homebrew Apache2 on Mac OS X (Mavericks)

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

Mac OS X comes with a built-in copy of Apache, so typing `sudo apachectl restart` from the command line is NOT going to restart our Homebrew installation of Apache, it will restart the default/built-in (i.e. older) copy of Apache that comes with OS X. **To avoid this problem,** use the full path to your `apachectl`; i.e. `sudo /usr/local/sbin/apachectl restart`

## Adding MySQL for use with PHP?

```
brew install mysql
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
```

Then type the following command and choose `Y` (uppercase) for all questions.
```
/usr/local/bin/mysql_secure_installation
```

----

*SEO: homebrew apache, homebrew apache24, homebrew apache 2.4, homebrew httpd, homebrew httpd24*  
*SEO: homebrew php, homebrew mysql, homebrew amp, homebrew lamp, homebrew mamp*
