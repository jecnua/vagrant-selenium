##Selenium on ubuntu

The vagrant machine is set to use 4096MB of memory and 1 CPU. You can change it
easily in the Vagrantfile.

##Prerequisites

You need:
- virtualbox
- vagrant

##Config

On the file:

    shell/bootstrap_ubuntu

There are some variables you can set to download the latest version of chrome
and selenium. That is the only thing you need to change.

##Run it

To run it

      vagrant up --provider=virtualbox

##Sources

I slightly change the bash script but is almost a perfect copy of one I found online at [lukemerrett.com blog post](http://www.lukemerrett.com/2014/01/28/installing-selenium-on-a-ubuntu-vm-with-vagrant/)
