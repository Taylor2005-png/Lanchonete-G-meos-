
import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var logogemeos: UIImageView!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Entrar: UIButton!
    @IBOutlet weak var bemvindo: UILabel!
    @IBOutlet weak var cadastrar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = . gray
        self.title = ""
        
        setupButton()
        setupLabel(text: "Bem Vindo!!!")
        setupUITextField()
        
        
        if let user = Auth.auth().currentUser {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.abrirHome()
            }
            // O usuário está logado
            print("Usuário está logado como \(user.uid)")
        }
    }
    
    func setupButton() {
        Entrar.setTitle("Entrar", for: .normal)
        Entrar.backgroundColor = .red
        Entrar.layer.cornerRadius = 11
        
        cadastrar.setTitle("Cadastrar", for: .normal)
        cadastrar.backgroundColor = .red
        cadastrar.layer.cornerRadius = 11
    }
    func setupLabel (text: String) {
        bemvindo.text = text
    }
    func setupUITextField() {
        self.Password.delegate = self
        self.Email.delegate = self
    }
    
    @IBAction func AbrirCadastro(_ sender: UIButton) {
        print("cliquei cadastro")
        
        // Criar uma instância da tela CadastroViewController
        let cadastroVC = CadastroViewController(nibName: "CadastroViewController", bundle: nil)
        
        // Apresentar a tela CadastroViewController
        self.present(cadastroVC, animated: true, completion: nil)
    }

    
    
    @IBAction func entrar(_ sender: UIButton) {
         guard let email = self.Email.text, !email.isEmpty else {
             openAlert(mensagem: "Preencha seu email", textefield: self.Email)
             return
         }
         
         guard let password = self.Password.text, !password.isEmpty else {
             openAlert(mensagem: "Preencha sua senha", textefield: self.Password)
             return
         }
         
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let errorMessage: String
                switch error._code {
                case AuthErrorCode.userNotFound.rawValue:
                    errorMessage = "Usuário não encontrado. Verifique o email fornecido."
                case AuthErrorCode.wrongPassword.rawValue:
                    errorMessage = "Senha incorreta. Verifique a senha fornecida."
                case AuthErrorCode.invalidEmail.rawValue:
                    errorMessage = "Email inválido. Verifique o formato do email."
                case AuthErrorCode.networkError.rawValue:
                    errorMessage = "Erro de conexão. Verifique sua conexão com a internet e tente novamente."
                default:
                    errorMessage = "Erro ao fazer login. Por favor, tente novamente mais tarde."
                }
                
                self.openAlert(mensagem: errorMessage)
                print("Erro ao fazer login:", errorMessage)
            }  else {
                abrirHome()
            }
         }
     }
    
    func openAlert(mensagem: String, textefield: UITextField? = nil) {
        let alert = UIAlertController(title: "atencao", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                if let field = textefield {
                    field.becomeFirstResponder()
                }
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func abrirHome() {
        let home = HomeViewController(nibName: "HomeViewController", bundle: nil)
        home.modalPresentationStyle = .fullScreen
        self.present(home, animated: true, completion: nil)
    }
    
}
