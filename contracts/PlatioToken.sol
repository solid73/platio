pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";


/**
 * @title Platio Token
 * @author Nikolai Kornilov
 */
contract PlatioToken is MintableToken, DetailedERC20 {
  constructor() public DetailedERC20("Platio Token", "PGAS", 4) {
  }
}
