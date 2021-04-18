import Foundation

enum ApiError: Error {
    case noData
}

protocol ApiClient {
    func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void) // Get players from API
    func getTeams(completion: @escaping (Result<[Team], Error>) -> Void) // Get all current NBA teams
    func getGames(completion: @escaping (Result<[Game], Error>) -> Void) // Get latest games
    func getOpps(idOpp: Int, completion: @escaping (Result<[Game], Error>) -> Void) //Get last games for selected team
}

class ApiClientImpl: ApiClient {
    
    func getOpps(idOpp: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://www.balldontlie.io/api/v1/games?seasons[]=2020&per_page[]=6&team_ids[]=\(idOpp)") else { return }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GamesResponse.self, from: data)
                completion(.success(response.data))
            } catch(let error) {
                print(error)
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
    
    func getPlayers(completion: @escaping (Result<[Player], Error>) -> Void) {
        let session = URLSession.shared

        guard let url = URL(string: "https://www.balldontlie.io/api/v1/players?page=61&per_page=50") else {return}
        let urlRequest = URLRequest(url: url)

        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PlayersResponse.self, from: data)
                completion(.success(response.data))
            } catch(let error) {
                print(error)
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
    
    func getGames(completion: @escaping (Result<[Game], Error>) -> ()) {
            let session = URLSession.shared
            
            guard let url = URL(string: "https://www.balldontlie.io/api/v1/games?page=1871") else { return }
            let urlRequest = URLRequest(url: url)
        
            let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
                guard let data = data else {
                    completion(.failure(ApiError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(GamesResponse.self, from: data)
                    completion(.success(response.data))
                } catch(let error) {
                    print(error)
                    completion(.failure(error))
                }
            })
    dataTask.resume()
}
    
    func getTeams(completion: @escaping (Result<[Team], Error>) -> ()) {
            let session = URLSession.shared
            
            guard let url = URL(string: "https://www.balldontlie.io/api/v1/teams") else { return }
            let urlRequest = URLRequest(url: url)
        
            let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in                
                guard let data = data else {
                    completion(.failure(ApiError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TeamsResponse.self, from: data)
                    completion(.success(response.data))
                } catch(let error) {
                    print(error)
                    completion(.failure(error))
                }
            })
            
            dataTask.resume()
        }
}


