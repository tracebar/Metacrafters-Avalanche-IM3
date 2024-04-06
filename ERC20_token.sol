// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Sanjan_token is ERC20 {
    address public owner;

    constructor() ERC20("SanjanToken", "STN") {
        owner = msg.sender;
        _mint(msg.sender, 100 * 10**uint(decimals()));
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can access");
        _;
    }

    function mint(address to, uint256 value) public onlyOwner {
        uint toMint = value * 10**uint(decimals());
        _mint(to, toMint);
    }

    function burn(uint256 value) public {
        uint toBurn = value * 10**uint(decimals());
        _burn(msg.sender, toBurn);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        _transfer(from, to, amount);

        uint256 currentAllowance = allowance(from, msg.sender);
        require(currentAllowance >= amount, "Sanjan_token: transfer amount exceeds allowance");
        
        _approve(from, msg.sender, currentAllowance - amount);

        return true;
    }
}
