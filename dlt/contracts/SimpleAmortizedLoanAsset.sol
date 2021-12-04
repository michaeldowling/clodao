// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;


import "./Interfaces/CLODAOAsset.sol";


contract SimpleAmortizedLoanAsset is CLODAOReceivablesAsset {

  uint32 principalAmount;
  uint32 dailyInterestRateAmount;

  constructor(uint32 principalAmt, uint32 dailyInterestRateAmt) {
    principalAmount = principalAmt;
    dailyInterestRateAmount = dailyInterestRateAmt;
  }


  /// @notice Get the currency this asset is denominated in
  /// @return The currency code this asset is denominated in
  function currency() external view returns (string memory) {
    return "USD";
  }

  /// @notice For example, if decimals equals 2, a balance of 505 tokens should be displayed to a user as 5,05 (505 / 10 ** 2).  Tokens usually opt for a value of 18, imitating the relationship between Ether and Wei.
  /// @return Returns the number of decimals used to get its user representation.
  function decimals() external view returns (uint8) {
    return uint8(2);
  }

  /// @notice Get the original princpal of this asset
  /// @return The amount of the original principal
  function principal() external view returns (uint32) {
    return principalAmount;
  }

  /// @notice Interest Rate, per day
  /// @return The interest rate per day, at 6 levels of precision
  function dailyInterestRate() external view returns (uint32) {
    return dailyInterestRateAmount;
  }

  /// @notice The method for calculating interest
  /// @return STATED_RATE or BANK_METHOD
  function interestCalculcationMethod() external view returns (string memory) {
    return "STATED_RATE";
  }


}
