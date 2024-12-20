## Builder reorg protection

See [REORG_LOSSES.md](https://github.com/flashbots/rbuilder/blob/f131f2fcbcece048ecfba96940a5c836fcee1ad6/docs/REORG_LOSSES.md) in the Flashbots rbuilder repo for more info.

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Deploy

```shell
$ forge script script/ReorgProtect.s.sol:ReorgProtectScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```
