// Tuffcoin ICO

// Version of compiler
pragma solidity ^0.4.11;

contract tuffcoin_ico {
    
    // Introducing the maximum number of tuffcoins available for sale
    uint public max_tuffcoins = 1000000;
    
    // Introducing the USD to Tuffcoins conversion rate
    uint public usd_to_tuffcoins = 1000;
    
    // Introducing the total number of Tuffcoins that have been bought by the investors
    uint public total_tuffcoins_bought = 0;
    
    // Mapping from the investor address to its equity in Tuffcoins and USD
    mapping(address => uint) equity_tuffcoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Tuffcoins
    modifier can_buy_tuffcoins(uint usd_invested) {
        require(usd_invested * usd_to_tuffcoins + total_tuffcoins_bought <= max_tuffcoins);
        _;
    }
    
    // Getting the equity in Tuffcoins of an investor
    function equity_in_tuffcoins(address investor) external constant returns(uint) {
        return equity_tuffcoins[investor];
    }
    
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns(uint) {
        return equity_usd[investor];
    }
    
    // Buying Tuffcoins
    function buy_tuffcoin(address investor, uint usd_invested) external
    can_buy_tuffcoins(usd_invested) {
        uint tuffcoins_bought = usd_invested * usd_to_tuffcoins;
        equity_tuffcoins[investor] += tuffcoins_bought;
        equity_usd[investor] = equity_tuffcoins[investor] / 1000;
        total_tuffcoins_bought += tuffcoins_bought;
    }
    
    
    // Selling Tuffcoins
    function sell_tuffcoin(address investor, uint tuffcoins_to_sell) external {
        equity_tuffcoins[investor] -= tuffcoins_to_sell;
        equity_usd[investor] = equity_tuffcoins[investor] / 1000;
        total_tuffcoins_bought -= tuffcoins_to_sell;
    }
}