const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Token contract", () => {
  let Token1, token1, Token2, token2, owner1, owner2;

  // Deploy the smart contracts
  beforeEach(async () => {
    Token1 = await ethers.getContractFactory("Token1");
    token1 = await Token1.deploy();
    [owner1, _] = await ethers.getSigners();

    Token2 = await ethers.getContractFactory("Token2");
    token2 = await Token2.deploy();
    [owner2, _] = await ethers.getSigners();
  });

  // Ensure that the smart contract interacted with has the assumed address
  it("Should have a specific smart contract address", async () => {
    const token2Address = token2.address;
    expect(token2Address).to.equal(
      "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"
    );
  });

  it("Should be possible to use the transferFrom method of token1 to transfer token2 to itself when it has allowance to do so", async () => {
    await token2.approve(token1.address, 100);

    const ownerAllowance = await token2.allowance(
      owner1.address,
      token1.address
    );
    expect(ownerAllowance).to.equal(100);

    await token2.transferFrom(owner1.address, token1.address, 50);

    await token1.interactWithToken2(50);
  });
});
