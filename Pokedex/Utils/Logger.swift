//
//  Logger.swift
//  MangaTCA
//
//  Created by mufkhalif on 27/08/24.
//

import Dependencies
import Foundation
import SwiftyBeaver

public struct Logger {
  private let logger: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self
    let file = FileDestination()
    let console = ConsoleDestination()
    let format = "$Dyyyy.MM.dd HH:mm:ss.SSS$d $C$L$c - $M $X"

    file.format = format
    file.logFileAmount = 10
    file.calendar = Calendar(identifier: .gregorian)
    file.logFileURL = FileUtil.logsDirectoryURL.appendingPathComponent(Defaults.FilePath.hanamiLog)

    console.format = format
    console.calendar = Calendar(identifier: .gregorian)
    console.asynchronously = false
    console.levelColor.verbose = "😪"
    console.levelColor.warning = "⚠️"
    console.levelColor.error = "‼️"
    console.levelColor.debug = "🐛"
    console.levelColor.info = "📖"

    log.addDestination(file)
    #if DEBUG
      log.addDestination(console)
    #endif

    return log
  }()

  public func error(_ message: Any, context: Any? = nil) {
    logger.error(message, context: context)
  }

  public func warning(_ message: Any, context: Any? = nil) {
    logger.warning(message, context: context)
  }

  public func info(_ message: Any, context: Any? = nil) {
    logger.info(message, context: context)
  }

  public func debug(_ message: Any, context: Any? = nil) {
    logger.debug(message, context: context)
  }

  public func verbose(_ message: Any, context: Any? = nil) {
    logger.verbose(message, context: context)
  }
}

extension Logger: DependencyKey {
  public static let liveValue = Logger()
}

public extension DependencyValues {
  var logger: Logger {
    get { self[Logger.self] }
    set { self[Logger.self] = newValue }
  }
}
