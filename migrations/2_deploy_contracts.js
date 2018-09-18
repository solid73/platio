const PlatioToken = artifacts.require('PlatioToken');
const PlatioCrowdsale = artifacts.require('PlatioCrowdsale');

module.exports = function(deployer) {
  deployer.deploy(PlatioToken).then(function() {
    return deployer.deploy(PlatioCrowdsale, PlatioToken.address);
  });
};
