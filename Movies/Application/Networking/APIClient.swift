//
//  APIClient.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire

struct APIClient {
    let disposeBag = DisposeBag()

    func request<T: Decodable>(url: URL, method: HTTPMethod, parameters: [String: Any], headers: HTTPHeaders) -> Single<T> {
        return Single.create { emitter -> Disposable in
            let request: Observable<(HTTPURLResponse, T)> = requestDecodable(method, url, parameters: parameters, headers: headers)

            request
                .subscribe(onNext: { httpUrlResponse, codableModel in
                    emitter(.success(codableModel))
                }, onError: { error in
                    emitter(.error(error))
                })
                .disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }
}
