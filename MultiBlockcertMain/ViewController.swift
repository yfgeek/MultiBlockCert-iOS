import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startScan(_ sender: Any) {
        JMSScanningQRCodeUtils.jm_cameraAuthStatus({
            self.navigationController?.pushViewController(ScanningQRCodeVC(), animated: true)
        }) {
            
        }
    }

}

