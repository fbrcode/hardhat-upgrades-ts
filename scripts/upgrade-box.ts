import { ethers, network, deployments, getNamedAccounts } from 'hardhat';

async function main() {
  // deploy V2 contract on the network
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const waitConfirmations = network.live === true ? 5 : 1;
  log(`----------------------------------------------------------`);
  const boxV2 = await deploy('BoxV2', {
    from: deployer,
    args: [],
    log: true,
    waitConfirmations: waitConfirmations,
  });
  log(`----------------------------------------------------------`);

  // Setup proxy contracts
  const boxProxyAdmin = await ethers.getContract('BoxProxyAdmin');
  const transparentProxy = await ethers.getContract('Box_Proxy');

  // get the current proxy address
  const proxyBoxV1 = await ethers.getContractAt('Box', transparentProxy.address);
  const current = await proxyBoxV1.version();
  console.log(`Proxy using implementation contract version: ${current.toString()}`);

  // upgrade proxy to v2 implementation contract
  const upgradeTx = await boxProxyAdmin.upgrade(transparentProxy.address, boxV2.address);
  console.log(`Upgrade transaction: ${upgradeTx.hash}`);
  await upgradeTx.wait(1);

  // get the new proxy to check the version
  const proxyBoxV2 = await ethers.getContractAt('BoxV2', transparentProxy.address);
  const upgrade = await proxyBoxV2.version();
  console.log(`Proxy using implementation contract version: ${upgrade.toString()}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

// calls:
// 1. yarn eth-node
// 2. yarn upgrade-box
