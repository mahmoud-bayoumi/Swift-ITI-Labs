//
//  CoreDataManager.swift
//  SwiftLab2
//
//  Created by Bayoumi on 23/04/2026.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    }()
    
    func saveMovie(movie: Movie) {
        let entity = MovieEntity(context: context)
        
        entity.id = Int64(movie.id)
        entity.title = movie.title
        entity.movieDescription = movie.description
        entity.releaseYear = Int64(movie.releaseYear)
        entity.rating = movie.rating
        entity.genre = movie.genre.joined(separator: ",")
        entity.posterURL = movie.posterURL
        
        if let image = movie.customImage,
           let data = image.jpegData(compressionQuality: 0.8) {
            
            let fileName = UUID().uuidString + ".jpg"
            let path = getDocumentsPath().appendingPathComponent(fileName)
            
            try? data.write(to: path)
            entity.imagePath = fileName
        }
        
        saveContext()
    }
    
    func fetchMovies() -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            return result.map { entity in
                Movie(
                    id: Int(entity.id),
                    title: entity.title ?? "",
                    description: entity.movieDescription ?? "",
                    releaseYear: Int(entity.releaseYear),
                    rating: entity.rating,
                    genre: entity.genre?.components(separatedBy: ",") ?? [],
                    customImage: loadImage(name: entity.imagePath),
                    posterURL: entity.posterURL ?? "",
                    imagePath: entity.imagePath ?? ""
                )
            }
            
        } catch {
            print("Fetch error:", error)
            return []
        }
    }
    
    func deleteMovie(id: Int) {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        if let result = try? context.fetch(request),
           let object = result.first {
            context.delete(object)
            saveContext()
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    private func getDocumentsPath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func loadImage(name: String?) -> UIImage? {
        guard let name = name else { return nil }
        let path = getDocumentsPath().appendingPathComponent(name)
        return UIImage(contentsOfFile: path.path)
    }
}
