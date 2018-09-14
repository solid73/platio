const PlatioToken = artifacts.require('PlatioToken');
const PlatioCrowdsale = artifacts.require('PlatioCrowdsale');

const wallet;
const startTime;
const endTime;
const rate;
const cap;
const goal;

module.exports = function(deployer) {
  deployer.deploy(PlatioToken);
  deployer.deploy(
    PlatioCrowdsale,
    wallet,
    startTime,
    endTime,
    rate,
    cap,
    goal,
    PlatioToken.address
  );
};
