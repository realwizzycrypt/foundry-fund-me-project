// Fund
// Withdraw

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {

    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);

        // vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        // vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {

    function withdrawFundMe(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("Withdrew FundMe balance!");
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);

        // vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        // vm.stopBroadcast();
    }
}
