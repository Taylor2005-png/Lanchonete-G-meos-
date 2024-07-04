
import UIKit
import SDWebImage
import FirebaseDatabase

class ResultadoProduto: UIViewController {
    @IBOutlet weak var imagemproduto: UIImageView!
    @IBOutlet weak var descriçao: UITextField!
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var categoria: UITextField!
    @IBOutlet weak var valor: UITextField!
    @IBOutlet weak var atualizar: UIButton!
    
    var produto: Produto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let produto = produto {
            titulo.text = produto.titulo
            descriçao.text = produto.descricao
            categoria.text = produto.categoria
            valor.text = produto.valor
            url.text = produto.url
            // Carregar a imagem da URL usando SDWebImage, se necessário
            if let url = URL(string: produto.url) {
                imagemproduto.sd_setImage(with: url, completed: nil)
            }
        }
        
    }
    
    @IBAction func atualizou(_ sender: Any) {
        guard let produto = produto else {
            return
        }
        print("[] ", produto.id)
        // Referência para o Realtime Database
        let ref = Database.database().reference().child("produtos").child(produto.id)
        
        let produtoAtualizado = [
            "titulo": titulo.text ?? "",
            "valor": valor.text ?? "",
            "descricao": descriçao.text ?? "" ,
            "categoria": categoria.text ?? "",
            "url":url.text ?? ""
        ] as [String : Any]
        
        // Atualiza os dados do produto no Firebase
        ref.setValue(produtoAtualizado) { (error, ref) in
            
            
            
            if let error = error {
                let alert = UIAlertController(title: "Error",
                                              message: "Erro ao atualizar o produto: \(error.localizedDescription)",
                                              preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                let alert = UIAlertController(title: "Produto Atualizado",
                                              message: "O produto foi atualizado com sucesso!",
                                              preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
    }
    
    
}
