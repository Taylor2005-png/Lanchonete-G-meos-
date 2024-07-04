
import UIKit
import FirebaseDatabase
import SDWebImage

class InicioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var manuinicio: UITableView!

    var produtos: [Produto] = [] // Array para armazenar os produtos
    
    override func viewDidLoad() {
        self.title = "Inicio"
        super.viewDidLoad()
        self.navigationController?.tabBarItem.image = UIImage(named: "wave.3.forward.circle")
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "antenna.radiowaves.left.and.right.circle.fill")
        // Configurar o título da aba, se necessário
        self.navigationController?.tabBarItem.title = "Inicio"
        
        
        let nib = UINib(nibName: "CelulaLojaTableViewCell", bundle: nil)
        manuinicio.register(nib, forCellReuseIdentifier: "CelulaLojaTableViewCell")

        // Set table view data source and delegate
        manuinicio.dataSource = self
        manuinicio.delegate = self

        // Carrega os produtos do Firebase
        loadProdutosFromFirebase()
    }
    

    func loadProdutosFromFirebase() {
        // Referência para o Realtime Database
        let ref = Database.database().reference().child("produtos")
        
        // Observa mudanças nos dados
        ref.observe(.value) { (snapshot) in
            guard let produtosData = snapshot.value as? [String: Any] else {
                print("Erro ao obter dados do Firebase")
                return
            }
            
            var produtosDictionary: [String: Produto] = [:] // Dicionário para armazenar os produtos
            
            // Itera sobre os produtos
            for (produtoID, produtoData) in produtosData {
                if let produtoInfo = produtoData as? [String: Any],
                   let titulo = produtoInfo["titulo"] as? String,
                   let valor = produtoInfo["valor"] as? String,
                   let descricao = produtoInfo["descricao"] as? String,
                   let categoria = produtoInfo["categoria"] as? String,
                   let url = produtoInfo["url"] as? String {
                    
                    // Cria um objeto Produto
                    let produto = Produto(id: produtoID, titulo: titulo, valor: valor, descricao: descricao, categoria: categoria, url: url)
                    
                    // Adiciona o produto ao dicionário usando o ID como chave
                    produtosDictionary[produtoID] = produto
                }
            }
            
            // Ordena os produtos com base nos seus IDs originais
            let produtosOrdenados = produtosDictionary.sorted { $0.key < $1.key }.map { $0.value }
            
            // Atualiza a lista de produtos com os produtos ordenados
            self.produtos = produtosOrdenados
            
            // Recarrega a table view
            self.manuinicio.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelulaLojaTableViewCell", for: indexPath) as! CelulaLojaTableViewCell
        
        let produto = produtos[indexPath.row]
        
        // Configura a célula com os dados do produto
        cell.titulo.text = produto.titulo
        cell.descriptionProduct.text = produto.descricao
        cell.valor.text = "R$: \(produto.valor)"
        
        // Carrega a imagem da URL usando SDWebImage
        if let url = URL(string: produto.url) {
            cell.imagemproduto.sd_setImage(with: url, completed: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let produtoSelecionado = produtos[indexPath.row]
       
        let resultado = ResultadoProduto(nibName: "ResultadoProduto", bundle: nil)
        resultado.produto = produtoSelecionado
        self.show(resultado, sender: nil)
    }
}

// Modelo de dados para representar um produto
struct Produto {
    let id: String
    let titulo: String
    let valor: String
    let descricao: String
    let categoria: String
    let url: String
}
 


