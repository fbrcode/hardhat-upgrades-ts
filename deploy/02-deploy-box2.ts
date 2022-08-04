import { DeployFunction } from 'hardhat-deploy/types';
import { HardhatRuntimeEnvironment } from 'hardhat/types';

import verify from '../utils/verify';

const deployContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const contractName = 'BoxV2';
  const { deployments, getNamedAccounts, network } = hre;
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const waitConfirmations = network.live === true ? 5 : 1;
  log(
    `Deploying ${contractName} on ${network.name} which is ${
      !network.live ? 'not' : ''
    } live network (wait confirmations: ${waitConfirmations})...`
  );

  const args: any[] = [];
  const contract = await deploy(contractName, {
    from: deployer,
    args: [],
    log: true,
    waitConfirmations: waitConfirmations,
    proxy: {
      proxyContract: 'OpenZeppelinTransparentProxy',
      viaAdminContract: {
        name: 'BoxProxyAdmin',
        artifact: 'BoxProxyAdmin',
      },
    },
  });

  if (network.live && process.env.ETHERSCAN_API_KEY) {
    log(`Verifying contract "${contract.address}" with args [${args}]...`);
    await verify(contract.address, args);
  }
  log(`----------------------------------------------------------`);
};

export default deployContract;
deployContract.tags = ['all', 'impl'];
