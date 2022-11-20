# Cosmos install helper
## Installing
* Run setup.sh if you are on Linux, setup.bat on Windows
* Run install.sh/bat
## Updating
* Run update.sh/bat
* Run install.sh/bat

### Note
If you want to install needed packages run setup.sh with `--install-pkg` argument.

If you are on Ubuntu,
```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```
run these command before running `setup.sh` (20.04)
