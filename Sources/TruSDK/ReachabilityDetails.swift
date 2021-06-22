//
//  ReachabilityDetails.swift
//  
//
//  Created by Murat Yakici on 02/06/2021.
//

import Foundation

/// A struct to hold the details of the Cellular network a request is made.
public struct ReachabilityDetails: Codable, Equatable {
    let countryCode: String
    let networkId: String
    let networkName: String
    let products: [Product]?
    let link: String

    public static func == (lhs: ReachabilityDetails, rhs: ReachabilityDetails) -> Bool {
        return lhs.countryCode == rhs.countryCode &&
            lhs.link == rhs.link &&
            lhs.networkId == rhs.networkId &&
            lhs.networkName == lhs.networkName &&
            lhs.products == rhs.products
    }

}

/// The TruID products available for the application developer on the celluar network the app is connected to.
public struct Product: Codable, Equatable {
    let productId: String
    let productType: ProductType
}

/// The TruID product types available for the application developer on the celluar network the app is connected to.
public enum ProductType:String, Codable {
    case PhoneCheck = "Phone Check"
    case SIMCheck = "Sim Check"
    case SubscriberCheck = "Subscriber Check"
}

/// A struct to hold the details of the error when `isReachable(...) request is made.
/// If the request was not made on a Cellular network, this struct will represent the details of the error.
public struct ReachabilityError: Error, Codable, Equatable {
    let type: String
    let title: String
    let status: Int
    let detail: String
}