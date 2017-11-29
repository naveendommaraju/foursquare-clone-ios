//
//  PlacesService.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 25/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Moya

enum PlacesApi {
    case recommended(latitude: Double, longitude: Double)
}

extension PlacesApi: TargetType {
    var baseURL: URL {
         return URL(string: "https://api.foursquare.com/v2")!
    }

    var path: String {
        switch self {
        case .recommended:
            return "/venues/explore"
        }
    }

    var method: Moya.Method {
        switch self {
        case .recommended:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .recommended(latitude, longitude):
            let parameters = requestParameters(latitude: latitude, longitude: longitude)
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)

        }
    }

    var headers: [String: String]? {
        return nil
    }

    private func requestParameters(latitude: Double, longitude: Double) -> [String: Any] {
        return [
            "v": "20171029",
            "venuePhotos": 1,
            "limit": 10,
            "ll": String(format: "%f,%f", latitude, longitude),
            "client_id": ServicesContants.foursquareClientId,
            "client_secret": ServicesContants.foursquareClientSecret]
    }
}
