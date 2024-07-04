
import UIKit
import Firebase

class PerfilViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Data source for table view
    let tableData = ["Perfil","Cadastrar produto","Sair"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Perfil"
        // Register custom cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Set table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        if indexPath.row == 0 {
            
            let cadastroVC = UsuarioViewController(nibName: "UsuarioViewController", bundle: nil)
            self.show(cadastroVC, sender: nil)
            
        } else if indexPath.row == 1 {
            
            let cadastroVC = CadastroprodutoViewController(nibName: "CadastroprodutoViewController", bundle: nil)
            self.show(cadastroVC, sender: nil)
            
            
        } else if indexPath.row == 2 {
            
            logout()
            
        }
    }
    
    func logout() {
        // Realizar logout do Firebase
        do {
            try Auth.auth().signOut()
            // Se o logout for bem-sucedido, feche esta tela modal
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Erro ao fazer logout: \(signOutError.localizedDescription)")
        }
    }
}
