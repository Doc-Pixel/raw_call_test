# @version >=0.3.7

remoteAddress: address

interface remoteContract:
    def setApprovalForAll(operator:address, approved: bool): nonpayable
    def isApprovedForAll(owner: address, operator: address) -> bool: nonpayable


@external
def __init__(remoteAddress:address):
    # set the remote address
    self.remoteAddress = remoteAddress


@internal
@nonpayable
def _approveContract() -> Bytes[32]: 
    # make a raw call as msg.sender (by setting is_delegate_call to True) 
    response: Bytes[32] = b""
    response = raw_call(
        self.remoteAddress,
        _abi_encode(self, True, method_id=method_id("setApprovalForAll(address,bool)")),
        is_delegate_call=True,
        max_outsize=32
        )
    return response

@external
def approve_remote():
    # approve this smart contract in the remote contract by using the raw call function.
    self._approveContract()

@external
def checkApproved_remote(owner:address, operator:address) -> bool:
    assert remoteContract(self.remoteAddress).isApprovedForAll(owner, operator), "not approved"
    return True