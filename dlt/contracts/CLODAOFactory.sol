// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "./CLODAORegistry.sol";
import "./CLODAO.sol";

contract CLODAOFactory {

  address public globalRegistryLocation;
  address public factoryOperator;

  constructor() {
    factoryOperator = msg.sender;
  }

  modifier onlyFactoryOperator {
    require(msg.sender == factoryOperator);
    _;
  }

  modifier onlyUninitRegistry {
    require(globalRegistryLocation == address(0x0));
    _;
  }

  function initializeGlobalRegistry() public onlyFactoryOperator onlyUninitRegistry {

    CLODAORegistry registry = new CLODAORegistry();
    globalRegistryLocation = address(registry);

  }

  function create(string calldata purpose) public onlyFactoryOperator {

    CLODAO dao = new CLODAO(globalRegistryLocation);
    CLODAORegistry registry = CLODAORegistry(globalRegistryLocation);
    registry.registerDAOFormation(address(dao), purpose);


  }

  function getGlobalRegistry() public view returns (address) {
    return globalRegistryLocation;
  }

  function getFactoryOperator() public view returns (address) {
    return factoryOperator;
  }



}
