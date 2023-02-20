import pytest
import brownie
from brownie import remote_contract, calling_contract, accounts , ZERO_ADDRESS

remote_address = ZERO_ADDRESS

##### test fixtures #####
@pytest.fixture
def owner():
    account = accounts[0]
    return account

def test_scenarios(remote_contract, calling_contract, accounts, owner):

    global remote_address
    remoteContract = remote_contract.deploy({"from": owner})
    remote_address = remoteContract.address

    callingContract = calling_contract.deploy(remote_address, {"from": owner})
    calling_address = callingContract.address

    callingContract.approve_remote({"from": owner})
    print(remoteContract.isApprovedForAll(owner, calling_address, {"from": owner}))

    print(callingContract.checkApproved_remote(owner, calling_address,{"from": owner}))  