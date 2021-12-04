pragma solidity ^0.8.0;

// SPDX-License-Identifier: Apache-2.0

contract CLODAORegistry {

  struct DeployedDAO {
    address daoLocation;
    string daoPurpose;
  }

  address owningFactory;
  address factoryOperator;

  mapping(address => DeployedDAO) public deployedDAOByAddress;
  mapping(string => address) public deployedDAOAddressesByPurpose;


  modifier onlyOwningFactory {
    require(msg.sender == owningFactory);
    _;
  }


  constructor() {
    owningFactory = msg.sender;
    factoryOperator = tx.origin;
  }

  function registerDAOFormation(address daoAddress, string calldata daoPurpose) public onlyOwningFactory {
    DeployedDAO memory dd = DeployedDAO(daoAddress, daoPurpose);
    deployedDAOByAddress[daoAddress] = dd;
    deployedDAOAddressesByPurpose[dd.daoPurpose] = daoAddress;
  }

  function getDAOAddressByPurpose(string calldata purpose) public view returns (address) {
    return deployedDAOAddressesByPurpose[purpose];
  }



  function getOwningFactory() public view returns (address) {
    return owningFactory;
  }

  function getFactoryOperator() public view returns (address) {
    return factoryOperator;
  }


}
