## Builder reorg protection

See [REORG_LOSSES.md](https://github.com/flashbots/rbuilder/blob/f131f2fcbcece048ecfba96940a5c836fcee1ad6/docs/REORG_LOSSES.md) in the Flashbots rbuilder repo for more info.

## Usage

### Install

```shell
git clone https://github.com/0xmichalis/builder-reorg-protect.git
cd builder-reorg-protect
forge install
```

### Build

```shell
$ forge build
```

### Deploy

```shell
forge create --rpc-url <your_rpc_url> \
    --private-key <your_private_key> \
    --etherscan-api-key <your_etherscan_api_key> \
    --verify \
    src/ReorgProtect.sol:ReorgProtect
```

### Contribute

```shell
forge snapshot -vvv
forge fmt
```
