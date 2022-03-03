
//const { WETH_10 } = require("./config")

const IERC20 = artifacts.require("IERC20");
const TestWethFlashMint = artifacts.require("Minter");

contract("TestWethFlashMint", (accounts) => {
  let testWethFlashMint;
  let weth;

  beforeEach(async () => {
    weth = await IERC20.at('0xf4BB2e28688e89fCcE3c0580D37d36A7672E8A9F')
    testWethFlashMint = await TestWethFlashMint.new()
  });

  it("Flashing", async () => {
    console.log('-----------------------------------------------------------------------------------------------------------');

    const tx = await testWethFlashMint.flash("1000000000000000000");

    console.log('-----------------------------------------------------------------------------------------------------------');
    console.log("Basic info: ");
    console.log(`Contract address: ${await testWethFlashMint.address}`);
    console.log(`Sender address: ${await testWethFlashMint.sender()}`);
    console.log(`WETH10 address: ${await testWethFlashMint.token()}`);
    console.log(" ");


    console.log('-----------------------------------------------------------------------------------------------------------');
    console.log("Visualize events: ");
    for (const log of tx.logs) {
      console.log(`${log.args.name} ${log.args.val}`)
    }
  })
})