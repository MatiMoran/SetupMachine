# Command Line Commands

# Git
## Set git push to create the remote branch
git config --add --bool push.autoSetupRemote true

# System
## Flash ISO Image into USB
sudo dd bs=4M if=/home/matias/Downloads/Win10_22H2_Spanish_x64v1.iso of=/dev/sdc conv=fdatasync
