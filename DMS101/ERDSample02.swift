
import Foundation

struct DirectDepositEntity: Decodable{
    var account_name: String? = ""
    var account_number: Int32 = 0
    var aba_number: String? = ""
    var amount: String? = ""
    var wallet_id: Int = 0
    
    init(wallet_id: Int, amount: String, account_name: String, account_number: Int32, aba_number: String? = nil ){
        self.wallet_id = wallet_id
        self.amount = amount
        self.account_name = account_name
        self.account_number = account_number
        self.aba_number = aba_number
    }
}
