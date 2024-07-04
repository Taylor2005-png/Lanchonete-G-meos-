
import UIKit
import Firebase

class CadastroViewController: UIViewController {
    @IBOutlet weak var logogemeos: UIImageView!
    @IBOutlet weak var verificaremail: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarsenha: UITextField!
    @IBOutlet weak var botaocadastrar: UIButton!
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func setupActivityIndicator() {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .gray
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            view.addSubview(activityIndicator)
        }
    
    @IBAction func cadastro(_ sender: UIButton) {
        guard let email = verificaremail.text, !email.isEmpty,
              let senha = senha.text, !senha.isEmpty,
              let confirmarSenha = confirmarsenha.text, !confirmarSenha.isEmpty else {
            // Mostrar um alerta se algum campo estiver vazio
            exibirAlerta(title: "Campos vazios", message: "Por favor, preencha todos os campos.")
            return
        }
        
        // Verificar se a senha e a confirmação de senha são iguais
        guard senha == confirmarSenha else {
            // Mostrar um alerta se as senhas não coincidirem
            exibirAlerta(title: "Senhas não coincidem", message: "As senhas digitadas não são iguais. Por favor, verifique.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
            if let error = error {
                // Houve um erro ao criar o usuário
                self.exibirAlerta(title: "Erro de Cadastro", message: error.localizedDescription)
            } else {
                // Cadastro bem-sucedido
                self.exibirAlerta(title: "Cadastro bem-sucedido", message: "Usuário cadastrado com sucesso!")
                // Você pode adicionar aqui qualquer lógica adicional após o cadastro bem-sucedido
            }
        }
        print("posso fazer cadastro")
    }
    
    @IBAction func voltar(_ sender: UIButton) {
        // Descartar a view controller atual e retornar à tela anterior
        self.dismiss(animated: true, completion: nil)
    }
    
    func exibirAlerta(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
