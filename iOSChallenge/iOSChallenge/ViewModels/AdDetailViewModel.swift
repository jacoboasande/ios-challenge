//
//  AdDetailViewModel 2.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import Foundation

class AdDetailViewModel: ObservableObject {
    let listItem: ListItem
    let detail: AdDetail

    init(listItem: ListItem, detail: AdDetail) {
        self.listItem = listItem
        self.detail = detail
    }

    var titleLine1: String {
        "\(detail.extendedPropertyType.localized) en \(listItem.address)"
    }
    var titleLine2: String {
        "\(listItem.province) - \(listItem.neighborhood)"
    }
}
