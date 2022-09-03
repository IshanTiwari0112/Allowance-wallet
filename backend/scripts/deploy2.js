async function main() {
    const Greeter = await hre.ethers.getContractFactory("Allowance");
    const greeter = await Greeter.deploy();

    await greeter.deployed();

    console.log("Greeter deployed to:", greeter.address);
    console.log('What chain: ', window.ethereum.networkVersion);
}

main()
    .then(()=> process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })