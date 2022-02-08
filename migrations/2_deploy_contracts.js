let Flashloan = artifacts.require("Minter");

module.exports = async function (deployer, network) {
    try {
        await deployer.deploy(Flashloan);
    } catch (e) {
        console.log(`Error in migration: ${e.message}`);
    }
}