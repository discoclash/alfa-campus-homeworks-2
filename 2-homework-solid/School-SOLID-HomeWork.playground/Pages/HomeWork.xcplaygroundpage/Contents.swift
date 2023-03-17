import UIKit
import PlaygroundSupport

// Необходимо переписать экран, чтоб код не нарушал принципы SOLID и использовал паттерны проектирования.
//
// На что обратить внимание:
// - Закрываем зависимости (связи между компонентами) протоколами;
// - Явное инжектирование зависимостей (через init устанавливаем зависимости компонента/объекта);
// - Распределить код по ролям, чтоб разгрузить контроллер;
//
// Дополнительно:
// - Добиться переиспользуемости экрана, используя паттерны проектирования.
// - Должна быть возможность пробросить любой сервис и получить список из другой API;

struct University: Decodable {
    let name: String
}

// MARK: - View

// протокол для вью
protocol DisplayMainView: UIView {
    func configurate()
}

// класс вью с таблицей
final class MainView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    required init(delegate: UITableViewDataSource & UITableViewDelegate) {
        super.init(frame: .zero)
        tableView.dataSource = delegate
        tableView.delegate = delegate
        configurateSubviews()
        configurateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// заполнение вью через доступный интерфейс
extension MainView: DisplayMainView {
    func configurate() {
        tableView.reloadData()
    }
}

// настройка вью
private extension MainView {
    func configurateSubviews() {
        addSubview(tableView)
    }
    
    func configurateConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}

// MARK: - ViewController

final class ReusableTableViewController: UIViewController {
    var universities: [University] = []
    var onClick: ((University) -> Void)?
    lazy var contentView: DisplayMainView = MainView(delegate: self)
    private let networkService: AnyNetworkService<University>
    
    // действие при клике и запрос данных задаём в инициализаторе
    required init(onClick: ((University) -> Void)? = nil, networkService: AnyNetworkService<University>) {
        self.onClick = onClick
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.fetchList { [weak self] result in
            switch result {
            case let .success(responce):
                self?.universities = responce
                self?.contentView.configurate()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// настройка таблицы
extension ReusableTableViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = universities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClick?(universities[indexPath.row])
    }
}

// MARK: - Networking

// Реализуем паттерн Type Erasure
protocol NetworkServicing: AnyObject {
    associatedtype Responce = Decodable
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void)
}

final class AnyNetworkService<T: Decodable>: NetworkServicing {
    typealias Responce = T
    private let fetchListMethod: (@escaping (Result<[Responce], Error>) -> Void) -> Void
    
    init<C: NetworkServicing>(_ concrete: C) where C.Responce == T {
        fetchListMethod = concrete.fetchList
    }
    
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void) {
        fetchListMethod(completion)
    }
}

final class UniversityService: NetworkServicing {
    typealias Responce = University
    
    private let uri: String
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(uri: String, urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = decoder
        self.uri = uri
    }
    
    func fetchList(completion: @escaping (Result<[Responce], Error>) -> Void) {
        
        guard let url = URL(string: self.uri) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard
                    let data = data,
                    let decodedData = try? self?.jsonDecoder.decode([Responce].self, from: data)
                else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                completion(.success(decodedData))
            }
        }
        
        dataTask.resume()
    }
}

/// Настраиваем экран и его зависимости 

let clickClosure = { data in
    print(data)
}
let networkService: AnyNetworkService<University> = .init(UniversityService(uri: "http://niversities.hipolabs.com/search?country=United+States"))

let viewController = ReusableTableViewController(onClick: clickClosure, networkService: networkService)
viewController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)

/// Playground

PlaygroundPage.current.liveView = viewController
