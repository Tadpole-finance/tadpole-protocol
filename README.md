Tadpole Protocol
=================

Tadpole Finance is an open source platform providing decentralized finance services for saving and lending. Tadpole Finance is an experimental project to create a more open lending markets, where users can make deposits and loans with any ERC20 tokens on the Ethereum network.

Tadpole Finance was initiated by forking Compound Finance project on Aug 28, 2020. 

To know more about this project, please read:

* Docs: https://doc.tadpole.finance/

For questions about interacting with Tapdole, please meet us at [our Telegram group](https://t.me/TadpoleFinance).

Contributing
============

Tadpole Finance is managed as an open source project. We invite all developers to participate in developing this project. As a reward, 10% of the TAD supply (Tadpole Finance platform token) will be distributed to developers who contribute to the Tadpole Finance codebase. This rewards program will last for 1 year, starting from December 2020.

Currently we are still defining rules and standards to join this collaboration. Mean while if you have any question let’s discuss them at dev Telegram group: https://t.me/TadpoleFinance.

Contracts
=========

We detail a few of the core contracts in the Tadpole protocol.

<dl>
  <dt>CToken, CErc20 and CEther</dt>
  <dd>The Tadpole cTokens, which are self-contained borrowing and lending contracts. CToken contains the core logic and CErc20 and CEther add public interfaces for Erc20 tokens and ether, respectively. Each CToken is assigned an interest rate and risk model (see InterestRateModel and Comptroller sections), and allows accounts to *mint* (supply capital), *redeem* (withdraw capital), *borrow* and *repay a borrow*. Each CToken is an ERC-20 compliant token where balances represent ownership of the market.</dd>
</dl>

<dl>
  <dt>Comptroller</dt>
  <dd>The risk model contract, which validates permissible user actions and disallows actions if they do not fit certain risk parameters. For instance, the Comptroller enforces that each borrowing user must maintain a sufficient collateral balance across all cTokens.</dd>
</dl>

<dl>
  <dt>TAD</dt>
  <dd>The Tadpole platform token. Holders of this token have the ability to govern the protocol via the governor contract. TAD is also used to pay the listing fees to add a new ERC-20 to the money markets.</dd>
</dl>

<dl>
  <dt>JumpRateModelV3</dt>
  <dd>Contracts which define interest rate models. These models algorithmically determine interest rates based on the current utilization of a given market (that is, how much of the supplied assets are liquid versus borrowed).</dd>
</dl>

<dl>
  <dt>Careful Math</dt>
  <dd>Library for safe math operations.</dd>
</dl>

<dl>
  <dt>ErrorReporter</dt>
  <dd>Library for tracking error codes and failure conditions.</dd>
</dl>

<dl>
  <dt>Exponential</dt>
  <dd>Library for handling fixed-point decimal numbers.</dd>
</dl>

<dl>
  <dt>SafeToken</dt>
  <dd>Library for safely handling Erc20 interaction.</dd>
</dl>

<dl>
  <dt>CollateralModel</dt>
  <dd>Contracts which define collateral rate models. Currently collateral rates are defined manually by admin. Our goal is to make CollateralModel which can  determine collateral rates algorithmically based on various variables like the token's liquidity, volatility, etc.</dd>
</dl>

<dl>
  <dt>CTokenFactory</dt>
  <dd>A contract factory to generate cToken. To add a new market into Tadpole, user send a request to Comptroller.createMarket() and it will call CTokenFactory to generate a new cToken smart contract into Ethereum network.</dd>
</dl>

<dl>
  <dt>PriceOracleV1</dt>
  <dd>Simple price oracle before we move to a more complex oracle to support an open lending ecosystem.</dd>
</dl>

Discussion
----------

For any concerns with the protocol, open an issue or visit us on [Telegram](https://t.me/TadpoleFinance) to discuss.

_Tadpole Finance, 2020_
