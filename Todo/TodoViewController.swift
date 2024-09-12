import UIKit

class TodoViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var titles: [String] = []
    var contents: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // デフォルトの値を登録
        saveData.register(defaults: ["titles": [], "contents": []])
        
        // UserDefaultsから保存されたデータを読み込む（安全にキャスト）
        if let savedTitles = saveData.object(forKey: "titles") as? [String] {
            titles = savedTitles
        }
        
        if let savedContents = saveData.object(forKey: "contents") as? [String] {
            contents = savedContents
        }

        titleTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // キーボードを閉じる
        return true
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let content = contentTextField.text, !content.isEmpty else {
            // タイトルまたは内容が空の場合、エラーメッセージを表示
            let alert = UIAlertController(title: "エラー", message: "タイトルまたは内容が空です。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // タイトルと内容を配列に追加
        titles.append(title)
        contents.append(content)
        
        // UserDefaultsに保存（配列全体を保存）
        saveData.set(titles, forKey: "titles")
        saveData.set(contents, forKey: "contents")
        
        // 保存完了メッセージの表示
        let alert: UIAlertController = UIAlertController(title: "追加", message: "Todoの追加が完了しました。", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // 保存後に前の画面に戻る
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
