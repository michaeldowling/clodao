var CLODAOFactory = artifacts.require("CLODAOFactory");
var SimpleAmortizedLoanAsset = artifacts.require("SimpleAmortizedLoanAsset");

module.exports = async function(deployer) {
  await deployer.deploy(CLODAOFactory);
  await deployer.deploy(SimpleAmortizedLoanAsset, 100000000, 68493);
};
