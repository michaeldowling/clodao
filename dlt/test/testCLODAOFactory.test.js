const CLODAOFactory = artifacts.require("CLODAOFactory");
const CLODAO = artifacts.require("CLODAO");
const CLODAORegistry = artifacts.require("CLODAORegistry");

contract("CLODAOFactory", (accounts) => {
  let factory;

  before(async () => {
      factory = await CLODAOFactory.deployed();
  });

  describe("Creating a new CLODAO", async () => {

    before("Call the initializeGlobalRegistry() method on the CLODAOFactory and create a dao", async () => {

      await factory.initializeGlobalRegistry({ from: accounts[0] });
      await factory.create("This is a test purpose", {from: accounts[0]});

    });

    it("Confirms via the global registry", async () => {

      const registryAddress = await factory.getGlobalRegistry();
      // console.log("Registry: " + registryAddress);

    });

    it("Registers the sender (us) as the factory owner", async () => {

      const owner = await factory.getFactoryOperator();
      // console.log("Owner: " + owner);
      // console.log("Accounts-0: " + accounts[0]);
      assert.equal(accounts[0], owner, "Owner should be the deployer");

    });

    it("Should have created a dao and registered it!", async () => {

      const registryAddress = await factory.getGlobalRegistry();
      const reg = await new CLODAORegistry(registryAddress);
      const daoAddress = await reg.getDAOAddressByPurpose("This is a test purpose");

      // console.log("DAO Address:  " + daoAddress);

      const dao = await new CLODAO(daoAddress);
      const daoRegAddr = await dao.getRegistry();

      assert.equal(registryAddress, daoRegAddr, "The Registry Address should be the same as the DAO Registry Address");


    });

    


  });
});
