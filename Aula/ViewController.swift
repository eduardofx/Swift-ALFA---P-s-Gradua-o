import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var campoGasolina: UITextField!;
    
    @IBOutlet var campoEtanol: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func calcular() {
        let valorGasolina = (campoGasolina.text! as NSString).doubleValue;
        let valorEtanol = (campoEtanol.text! as NSString).doubleValue;
        if(valorGasolina <= 0 || valorEtanol <= 0)
        {
            showMessage(titulo: "ALERTA", mensagem: "Valores inválidos");
        }
        if(valorEtanol <= (valorGasolina*0.7))
        {
            showMessage(titulo: "ALERTA", mensagem: "Etanol é melhor")
            return
        }
        else
        {
            showMessage(titulo: "ALERTA", mensagem: "Gasolina é melhor")
        }
        
    }
    func showMessage(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert);
        alerta.addAction(UIAlertAction(title: "CONFIRMAR", style: .default, handler:nil));
        self.present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func compartilhar(){
        let alerta = UIAlertController(title: "Compartilhar", message: "Escolha Onde Compartilhar", preferredStyle: .actionSheet);
        let whatsappAction = UIAlertAction(title: "WhatsApp", style: .default){action -> Void in self.compartilharWhatsapp();}
        let emailAction = UIAlertAction(title:"Email", style: .default){ action -> Void in self.compartilharEmail();}
        let voltarAction = UIAlertAction(title: "Voltar", style: .cancel, handler: nil)
        let exibirAction = UIAlertAction(title: "EXIBIR", style: .default){ action -> Void in self.showMessage(titulo: "Alerta",mensagem: self.mensagemCompartilhar()) }
        
        alerta.addAction(emailAction)
        alerta.addAction(whatsappAction)
        alerta.addAction(voltarAction)
        alerta.addAction(exibirAction)
        
        
        self.present(alerta, animated: true, completion: nil)
    }
    
    func mensagemCompartilhar()->String{
        return "VALOR GASOLINA: \(campoGasolina.text!).  VALOR ETANOL \(campoEtanol.text!)"
    }
    
    func compartilharEmail(){
        if (MFMailComposeViewController.canSendMail())
        {
            let compose = MFMailComposeViewController()
            compose.mailComposeDelegate = self
            compose.setToRecipients(["eduardok.fx@gmail.com"])
            compose.setSubject("Assunto")
            compose.setMessageBody("Mensagem: \(mensagemCompartilhar())", isHTML: true)
            compose.addAttachmentData(UIImageJPEGRepresentation(UIImage(named:"imagem.jpg")!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName: "imagem.jpg")
            self.present(compose, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func compartilharWhatsapp(){
        let link = "whatsapp://send?text="
        
        if let chamaLink = URL(string: link)
        {
            UIApplication.shared.open(chamaLink, options: [:], completionHandler: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
