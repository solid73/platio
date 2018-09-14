pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/StandardBurnableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import "openzeppelin-solidity/contracts/ownership/Contactable.sol";


/**
 * @title Platio Token
 */
contract PlatioToken is StandardBurnableToken, DetailedERC20, Contactable {
  uint public constant limit = 39750000;

  constructor() public DetailedERC20("Platio Token", "PGAS", 4) {
  }

  function calculateFee(uint _value) public pure returns (uint) {
    return _value.div(100).mul(5);
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(_fee(msg.sender, _value));
    return super.transfer(_to, _value);
  }

  function transferFrom(
    address _from,
    address _to,
    uint _value
  )
    public
    returns (bool)
  {
    require(_fee(_from, _value));
    return super.transferFrom(_from, _to, _value);
  }

  function approve(address _spender, uint _value) public returns (bool) {
    require(_fee(msg.sender, _value));
    return super.approve(_spender, _value);
  }

  function increaseApproval(
    address _spender,
    uint _addedValue
  )
    public
    returns (bool)
  {
    require(_fee(msg.sender, allowance(msg.sender, _spender).add(_addedValue)));
    return super.increaseApproval(_spender, _addedValue);
  }

  function decreaseApproval(
    address _spender,
    uint _subtractedValue
  )
    public
    returns (bool)
  {
    require(_fee(msg.sender, 0));
    return super.decreaseApproval(_spender, _subtractedValue);
  }

  function burn(uint _value) public {
    require(_fee(msg.sender, _value));
    return super.burn(_value);
  }

  function burnFrom(address _from, uint _value) public {
    require(_fee(_from, _value));
    return super.burnFrom(_from, _value);
  }

  function _fee(address _from, uint _value) internal returns (bool) {
    if (
      totalSupply().
      sub(calculateFee(_value).div(2)) >= calculateFee(_value).div(2)
    )
    {
      if (_from == msg.sender) {
        require(_value.add(calculateFee(_value)) <= balanceOf(_from));
        _burn(_from, calculateFee(_value).div(2));
        transfer(owner, calculateFee(_value).div(2));
      } else {
        require(
          _value.add(calculateFee(_value)) <= allowance(_from, msg.sender)
        );
        _burn(_from, calculateFee(_value).div(2));
        transferFrom(_from, owner, calculateFee(_value).div(2));
      }
    }
    return true;
  }
}
