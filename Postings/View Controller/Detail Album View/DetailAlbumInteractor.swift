//
//  DetailAlbumInteractor.swift
//  Postings
//
//  Created by Elabram MacbookPro on 08/12/21.
//

import Foundation
import Alamofire

class DetailAlbumInteractor: PresenterToInteractorDetailAlbumProtocol{
    
    var presenter: InteractorToPresenterDetailAlbumProtocol?
    
    var albumId: Int = .zero
    let albumURL = "https://jsonplaceholder.typicode.com/photos?albumId="
    
    let noDataMessage = "404: Sorry we're unable to find data"
    
    init(presenter: InteractorToPresenterDetailAlbumProtocol, albumId: Int) {
        self.presenter = presenter
        self.albumId = albumId
    }
    
    func apiPhotoIndex(parameters: [String : Any]) {
        let url = albumURL+"\(albumId)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result{
                    
                case .success(let value):
                    print(value)
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        if let data = response.data{
                            
                            let response = try decoder.decode([Photo].self, from: data)
                            
                            self.presenter?.successGetPhotoIndex(response: response)

                        } else {
                            
                            self.presenter?.failureGetPhotoIndex(message: self.noDataMessage)
                            
                        }
                        
                    } catch let err {
                        
                        self.presenter?.failureGetPhotoIndex(message: err.localizedDescription)
                        
                    }

                case .failure(let err):
                    self.presenter?.failureGetPhotoIndex(message: err.localizedDescription)
                }
            }
    }
    
    func storeAndShareLabel(withURLString: String) {
        guard let url = URL(string: withURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        //        /// START YOUR ACTIVITY INDICATOR HERE
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                /// STOP YOUR ACTIVITY INDICATOR HERE
//                self.share(url: tmpURL)
                self.presenter?.share(url: tmpURL)
                
            }
        }.resume()
    }
    
    
}
