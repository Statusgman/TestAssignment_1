//
//  NewsService.swift
//  TestAssignment-1
//
//  Created by Dudarenko Ilya on 24/04/2017.
//  Copyright © 2017 Dudarenko Ilya. All rights reserved.
//

import Foundation
import CoreData

enum NewsServiceError: Error {
    case noInternetConnection
    case loadingFailed(Error)
    case parsingFailed
    case cachingFailed
}

extension NewsServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Нет подключения к сети интернет"
        case .loadingFailed(_):
            return  "Не удалось получить данные"
        case .parsingFailed:
            return "Не удалось обработать данные"
        case .cachingFailed:
            return "Не удалось сохранить данные"
        }
    }
}

typealias ErrorClosure = (Error?)->()

/**
 * Сервис, предоставляющий данные в UI
 * Cписок новостей и детальная информация новости
 */
protocol NewsService {
    /**
     Обновление списка новостей
     @param completion блок выполнится после получения списка новостей, может содержать ошибку
     */
    func updateNewsList(with completion: @escaping ErrorClosure)
    
    /**
     Получить список новостей
     */
    func obtainNews()->([NewsTitle])
    
    /**
     NSFetchedResultsController для списка новостей
     */
    var resultsController: NSFetchedResultsController<NewsTitle> {get}
    
    /**
     Обновить детальную информацию новости
     @param identifier ID новости
     @param completion блок выполнится после получения информации, может содержать ошибку
     */
    func updateNewsDetail(with identifier:Int, and completion: @escaping ErrorClosure)
    
    /**
     Получить детальную информацию новости
     @param identifier ID новости
     @return optional NewsRecord
     */
    func obtainNewsDetail(with identifier: Int)->(NewsRecord?)
}
