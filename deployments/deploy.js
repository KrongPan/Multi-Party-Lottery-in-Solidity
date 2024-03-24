async function main() {
    const Lottery = await ethers.getContractFactory("Lottery");
    const lottery = await Lottery.deploy(10,40,40,40);
    console.log("Contract Deployed to Address:", lottery.address);
  }
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });