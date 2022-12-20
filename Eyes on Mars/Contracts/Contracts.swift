//
//  Contracts.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import Foundation


protocol UIUpdateProtocol {
    func didRecieveData()
    func didRecieveError(error: EMError)
    func willStartLoading()
    func didFinishLoading()
}
