pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";


/**
 * @title Platio Token
 * @author Nikolai Kornilov
 */
contract PlatioCrowdsale is 
  CappedCrowdsale, 
  RefundableCrowdsale, 
  MintedCrowdsale 
{
 constructor(
  address _wallet,
  uint _startTime,
  uint _endTime,
  uint _rate,
  uint _cap,
  uint _goal,
  MintableToken _token
 )
  public
  Crowdsale(_rate, _wallet, _token)
  CappedCrowdsale(_cap)
  TimedCrowdsale(_startTime, _closingTime)
  RefundableCrowdsale(_goal)
 {
  require(_goal <= _cap);
 }
}
