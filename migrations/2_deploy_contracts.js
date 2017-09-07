var Splitter = artifacts.require("./Splitter.sol");
var GroupSplitter = artifacts.require("./GroupSplitter.sol");

module.exports = function(deployer) {
  deployer.deploy(Splitter);
  deployer.link(Splitter, GroupSplitter);
  deployer.deploy(GroupSplitter);
};
