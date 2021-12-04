// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;


import "./Interfaces/CLODAOAsset.sol";

contract CLODAO {

  struct Statistics {

    uint32 totalAssetCount;
    uint32 totalPrincipal;
    uint32 averageInterestRate;
    uint32 lowestInterestRate;
    uint32 highestInterestRate;
    uint32 medianInterestRate;

    uint32 totalPotentialMonthlyIncome;


  }

  event AssetAdded(address indexed asset);


  address public registryLocation;
  address public factoryLocation;
  address public daoSponsor;

  address[] public clodaoAssets;
  Statistics public statistics;


  modifier onlyDaoSponsor {

    require(msg.sender == daoSponsor);
    _;

  }

  constructor(address currentRegistry) {
    factoryLocation = msg.sender;
    registryLocation = currentRegistry;
    daoSponsor = tx.origin;

    statistics = Statistics(
      0,
      0,
      0,
      0,
      0,
      0,
      0
    );

  }

  function getFactory() public view returns (address) {
    return factoryLocation;
  }

  function getRegistry() public view returns (address) {
    return registryLocation;
  }

  function getStatistics() public view returns (uint32, uint32) {
    return (statistics.totalAssetCount, statistics.totalPrincipal);
  }


  // What is the process for DAO issuance and assets?
  // The DAO sponsor (i.e. the one who called the factory) can "deposit" assets into the CLODAO.
  // Each deposit action stores the assets into a buffer, where they can be removed at any time
  // The assets in the buffer have a price (denominated in various currencies), and the buffer total
  // is used to track when a deal is closed.


  function addAsset(address clodaoAssetAddr) public onlyDaoSponsor {

    CLODAOReceivablesAsset asset = CLODAOReceivablesAsset(clodaoAssetAddr);
    statistics.totalAssetCount++;
    statistics.totalPrincipal += asset.principal();

    clodaoAssets.push(clodaoAssetAddr);
    emit AssetAdded(clodaoAssetAddr);

  }


}
