import UIKit
import WebKit
import SwiftyJSON

enum JMSScanningResultType {
    case qrCode, barCode
}

class JMSScanningResultVC : UIViewController {
    
    var resultType: JMSScanningResultType = .qrCode
    var resultInfo: String                = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        switch resultType {
        case .qrCode:
            setupWebView()
        default:
            setupLabel()
            
        }
    }
    
    func setupLabel() {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.init(x: 20, y: 200, width: self.view.frame.size.width, height: 30)
        titleLabel.text          = "Result:  "
        titleLabel.textColor     = .blue
        titleLabel.textAlignment = .left
    
        view.addSubview(titleLabel)
    
        // 扫描结果
        let IssuerLabel            = UILabel()
        let RecipientLabel            = UILabel()
        let IssuedDateLable            = UILabel()

        IssuerLabel.frame          = CGRect.init(x: 20, y: titleLabel.frame.maxY, width: self.view.frame.size.width, height: 20)
        RecipientLabel.frame    = CGRect.init(x: 20, y: IssuerLabel.frame.maxY, width: self.view.frame.size.width, height: 20)
        IssuedDateLable.frame    = CGRect.init(x: 20, y: RecipientLabel.frame.maxY, width: self.view.frame.size.width, height: 20)
        
        let data = self.resultInfo.data(using: .utf8)
        let json = JSON(data: data!)
        //String
        let name = json["issuer"]["name"].string
        let recipient = json["recipient"]["givenName"].string
        let recipientf = json["recipient"]["familyName"].string
        let issuedDate = json["assertion"]["issuedOn"].string
        IssuerLabel.text           = "Issuer:" + name!
        RecipientLabel.text           = "Recipient: " + recipient! + " " + recipientf!
        
        IssuedDateLable.text           = "Issued Date: " +  issuedDate!
        
        IssuerLabel.textAlignment  = .left
        
        RecipientLabel.textAlignment  = .left
        
        IssuedDateLable.textAlignment  = .left

        view.addSubview(IssuerLabel)
        view.addSubview(RecipientLabel)
        view.addSubview(IssuedDateLable)

    }
    
    func setupWebView() {
        guard let url = URL.init(string: resultInfo) else {
            return
        }
        let webView = WKWebView.init(frame: self.view.bounds)
        webView.load(URLRequest.init(url: url))
        
        view.addSubview(webView)
    }
    
    
}
