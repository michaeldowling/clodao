const CLODAOFactory = artifacts.require("CLODAOFactory");
const CLODAO = artifacts.require("CLODAO");
const CLODAORegistry = artifacts.require("CLODAORegistry");
const SimpleAmortizedLoanAsset = artifacts.require("SimpleAmortizedLoanAsset");


contract("CLODAOReceivablesAsset", (accounts) => {

  let factory;


  before(async () => {
      factory = await CLODAOFactory.deployed();
  });

  describe("Adding assets to a CLODAO", async () => {

    let dao;

    before("Setup the CLODAO", async () => {

      await factory.initializeGlobalRegistry({ from: accounts[0] });
      await factory.create("Issue_2021Dec_Receivables", {from: accounts[0]});

      const registryAddress = await factory.getGlobalRegistry();
      const reg = await new CLODAORegistry(registryAddress);
      const daoAddress = await reg.getDAOAddressByPurpose("Issue_2021Dec_Receivables");
      dao = await new CLODAO(daoAddress);

    });

    it("Adds a new asset", async () => {

      const asset = await SimpleAmortizedLoanAsset.deployed();
      await dao.addAsset(asset.address);
      const totals = await dao.getStatistics();

      assert.equal(100000000, totals[1], "Total Principal should be $1,000,000.00");
      assert.equal(1, totals[0], "Total Assets should be 1");



    });


  });



});
