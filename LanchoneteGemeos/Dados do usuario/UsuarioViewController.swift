
import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsuarioViewController: UIViewController {
    
    @IBOutlet weak var imagemlogo: UIImageView!
    @IBOutlet weak var nomecompleto: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var cpf: UITextField!
    @IBOutlet weak var datanascimento: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var atualizar: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configura a referência ao Realtime Database
        ref = Database.database().reference()
        carregarInformacoesUsuario()
        setupButton()
    }
    func setupButton() {
        atualizar.setTitle("Atualizar", for: .normal)
        atualizar.backgroundColor = .red
        atualizar.layer.cornerRadius = 15
    }
    func carregarInformacoesUsuario() {
        // Verifica se o usuário está autenticado no Firebase
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuário não está autenticado")
            return
        }
        
        // Referência ao nó do usuário no Realtime Database
        let userRef = ref.child("users").child(userId).child("Dados")
        
        // Observa alterações nos dados do usuário no Realtime Database
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let userData = snapshot.value as? [String: String] else {
                print("Nenhuma informação encontrada para o usuário")
                return
            }
            
            // Atualiza os textfields com as informações do usuário
            self.nomecompleto.text = userData["nomeCompleto"]
            self.telefone.text = userData["telefone"]
            self.cpf.text = userData["cpf"]
            self.datanascimento.text = userData["dataNascimento"]
            self.endereco.text = userData["endereco"]
        }
    }
    
    @IBAction func atualizandotela(_ sender: UIButton) {
        
        if let nome = nomecompleto.text {
            gravarInformacao(valor: nome, chave: "nomeCompleto")
        }
        if let telefone = telefone.text {
            gravarInformacao(valor: telefone, chave: "telefone")
        }
        if let cpf = cpf.text {
            gravarInformacao(valor: cpf, chave: "cpf")
        }
        if let dataNascimento = datanascimento.text {
            gravarInformacao(valor: dataNascimento, chave: "dataNascimento")
        }
        if let endereco = endereco.text {
            gravarInformacao(valor: endereco, chave: "endereco")
        }
    }
    
    func gravarInformacao(valor: String, chave: String) {
        // Verifica se o usuário está autenticado no Firebase
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Usuário não está autenticado")
            return
        }
        
        // Referência ao nó do usuário no Realtime Database
        let userRef = ref.child("users").child(userId).child("Dados")
        
        // Grava o valor no Realtime Database
        userRef.child(chave).setValue(valor)
    }
    
}
