# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

To interact with the contracts from the console:
```shell
npx hardhat console --network network(name of the network)
```

For this example:
```shell
const [owner, addr1, addr2] = await ethers.getSigners()
const c = await ethers.getContractAt("SimpleStorage","0x5FbDB2315678afecb367f032d93F642f64180aa3")
await c.connect(owner).setMessage("I love Chainlink")
await c.connect(addr1).setMessage("Merhaba")
```
