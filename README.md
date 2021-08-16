# pmbootstrap

- upsteam: https://gitlab.com/postmarketOS/pmbootstrap
- ngi-nix: https://github.com/ngi-nix/ngi/issues/198

Sophisticated chroot/build/flash tool to develop and install postmarketOS.

> :warning: As most Flakes in `nig-ngi` this Flake is a **work in progress**!

## Using

In order to use this [flake](https://nixos.wiki/wiki/Flakes) you need to have the 
[Nix](https://nixos.org/) package manager installed on your system. Then you can simply run this 
with:

```
$ nix run github:ngi-nix/pmbootstrap
```

You can also enter a development shell with:

```
$ nix develop github:ngi-nix/pmbootstrap
```

For information on how to automate this process, please take a look at [direnv](https://direnv.net/).
