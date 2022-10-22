const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("Simple Storage Unit Test", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deploySimpleStorageFixture() {
    
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();
    const simpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
    const simpleStorage = await simpleStorageFactory.deploy();


    // const Lock = await ethers.getContractFactory("Lock");
    // const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

    return { simpleStorage, owner, otherAccount };
  }

  describe("Deployment", async function() {
    it("Should set message to Chainlink Turkey Bootcamp", async function() {
      
    })
  })

  describe("#setMessage", async function() {
    describe("failure", async function() { 
      it("should revert if caller is not the owner", async function() {
        const {simpleStorage, otherAccount} = await loadFixture(deploySimpleStorageFixture);

        await expect(simpleStorage.connect(otherAccount).setMessage("arbitrary string")).to.be.revertedWith("Not an owner");
      })

      it("should revert if input string is empty", async function() {
        const {simpleStorage, otherAccount} = await loadFixture(deploySimpleStorageFixture);
        
        await expect(simpleStorage.setMessage("")).to.be.revertedWith("Empty string not allowed");
      })
    })

    describe("success", async function() { 
      it("should change message variable", async function() {
        const {simpleStorage, owner} = await loadFixture(deploySimpleStorageFixture);

        const newMessage = "Chainlink Turkey is the best!";
        await simpleStorage.connect(owner).setMessage(newMessage)
        const updatedMessage = await simpleStorage.getMessage();
  
        assert(newMessage === updatedMessage, "Message not right.");
      })

      it("emits MessageChanged", async function() {
        const {simpleStorage, owner} = await loadFixture(deploySimpleStorageFixture);

        const newMessage = "I love Chainlink Turkey";

        await expect(simpleStorage.connect(owner).setMessage(newMessage)).to.emit(simpleStorage, "MessageChanged").withArgs(newMessage);
      })
    })
  })
});

