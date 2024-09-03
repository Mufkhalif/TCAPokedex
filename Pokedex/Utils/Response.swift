//
//  Response.swift
//  MangaTCA
//
//  Created by mufkhalif on 26/08/24.
//

import Foundation

public struct Response<ResponseData>: Decodable, Equatable where ResponseData: Equatable & Decodable {
  public let result: String
  public let response: `Type`
  public let data: ResponseData
  public let limit: Int?
  public let total: Int?

  public enum `Type`: String, Decodable {
    case collection, entity
  }
}
