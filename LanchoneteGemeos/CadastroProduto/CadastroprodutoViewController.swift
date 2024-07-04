
import UIKit
import FirebaseDatabaseInternal
import Firebase

class CadastroprodutoViewController: UIViewController {
    
    @IBOutlet weak var imagemproduto: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var URL: UITextField!
    @IBOutlet weak var categoria: UITextField!
    @IBOutlet weak var cadastrar: UIButton!
   @IBOutlet weak var valor: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
    }
    
    @IBAction func cadastrarProduto(_ sender: UIButton) {
        // Verificar se os campos obrigatórios estão preenchidos
        guard let titulo = titulo.text, !titulo.isEmpty,
              let descricao = descricao.text, !descricao.isEmpty, let preco = valor.text, !preco.isEmpty else {
            // Mostrar uma mensagem de erro ao usuário
            print("Por favor, preencha todos os campos obrigatórios.")
            return
        }
        
        // Referência para o Realtime Database
        let ref = Database.database().reference().child("produtos").childByAutoId()
        
        // Criar um dicionário com os dados do produto
        let produtoData: [String: Any] = [
            "titulo": titulo,
            "descricao": descricao,
            "valor": preco,
            "url": URL.text ?? "", // URL é opcional, então verifica se está vazio
            "categoria": categoria.text ?? "" // Categoria é opcional, então verifica se está vazio
            // Adicione outros campos conforme necessário
        ]
        
        // Salvar os dados do produto no Realtime Database
        ref.setValue(produtoData) { (error, _) in
            if let error = error {
                print("Erro ao cadastrar produto: \(error.localizedDescription)")
            } else {
                print("Produto cadastrado com sucesso!")
                // Limpar os campos após o cadastro, se necessário
                self.clearFields()
            }
        }
    }
    
    @IBAction func eventoDeClique(_ sender: UIButton) {
        print("cliquei aqui")
    }
    
    func setupButton() {
        cadastrar.setTitle("Cadastrar", for: .normal)
        cadastrar.backgroundColor = .red
        cadastrar.layer.cornerRadius = 10
    }
    
    private func clearFields() {
            titulo.text = ""
            descricao.text = ""
            URL.text = ""
            categoria.text = ""
            // Limpar a imagem do produto, se necessário
            imagemproduto.image = nil
        }
    }
