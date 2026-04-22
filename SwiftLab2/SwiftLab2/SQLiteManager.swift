//
//  SQLiteManager.swift
//  SwiftLab2
//
//  Created by Bayoumi on 22/04/2026.
//

import Foundation
import SQLite3

class SQLiteManager {
    
    static let shared = SQLiteManager()
    
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    

    private func openDatabase() {
        let path = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Movies.sqlite").path
        
        // sqlite3_open() -> opens/creates database file
        if sqlite3_open(path, &db) == SQLITE_OK {
            print("Database opened at: \(path)")
        } else {
            print("Failed to open database")
        }
    }
    
    private func createTable() {
        let query = """
            CREATE TABLE IF NOT EXISTS movies (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                subtitle TEXT,
                description TEXT,
                releaseYear INTEGER,
                rating REAL,
                genre TEXT,
                posterURL TEXT
            );
        """
        
        // sqlite3_exec = shortcut for prepare + step + finalize
        if sqlite3_exec(db, query, nil, nil, nil) == SQLITE_OK {
            print("Table created")
        }
    }
    
    func insertMovie(_ movie: Movie) {
        let query = "INSERT OR REPLACE INTO movies (id, title, subtitle, description, releaseYear, rating, genre, posterURL) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            
            sqlite3_bind_int(stmt, 1, Int32(movie.id))
            sqlite3_bind_text(stmt, 2, (movie.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (movie.subtitle as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (movie.description as NSString).utf8String, -1, nil)
            sqlite3_bind_int(stmt, 5, Int32(movie.releaseYear))
            sqlite3_bind_double(stmt, 6, movie.rating)
            sqlite3_bind_text(stmt, 7, (movie.genre.joined(separator: ",") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 8, (movie.posterURL as NSString).utf8String, -1, nil)
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Inserted: \(movie.title)")
            } else {
                print("Insert failed")
            }
        } else {
            print("Prepare failed")
        }
        
        sqlite3_finalize(stmt)
    }
    

    func getAllMovies() -> [Movie] {
        let query = "SELECT * FROM movies;"
        var stmt: OpaquePointer?
        var movies: [Movie] = []
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            
            while sqlite3_step(stmt) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(stmt, 0))
                let title = String(cString: sqlite3_column_text(stmt, 1))
                let subtitle = String(cString: sqlite3_column_text(stmt, 2))
                let description = String(cString: sqlite3_column_text(stmt, 3))
                let releaseYear = Int(sqlite3_column_int(stmt, 4))
                let rating = sqlite3_column_double(stmt, 5)
                let genre = String(cString: sqlite3_column_text(stmt, 6))
                let posterURL = String(cString: sqlite3_column_text(stmt, 7))
                
                let movie = Movie(
                    id: id,
                    title: title,
                    subtitle: subtitle,
                    description: description,
                    imageName: "movie",
                    releaseYear: releaseYear,
                    rating: rating,
                    genre: genre.components(separatedBy: ","),
                    posterURL: posterURL
                )
                movies.append(movie)
            }
        }
        
        
        sqlite3_finalize(stmt)
        return movies
    }
    
    func deleteMovie(id: Int) {
        let query = "DELETE FROM movies WHERE id = ?;"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(id))
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Deleted movie id: \(id)")
            }
        }
        
        sqlite3_finalize(stmt)
    }
    
    func deleteAll() {
        let query = "DELETE FROM movies;"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_step(stmt)
        }
        sqlite3_finalize(stmt)
    }
    
    func getNextId() -> Int {
        let query = "SELECT MAX(id) FROM movies;"
        var stmt: OpaquePointer?
        var maxId = 0
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_ROW {
                maxId = Int(sqlite3_column_int(stmt, 0))
            }
        }
        sqlite3_finalize(stmt)
        return maxId + 1
    }
    

    func closeDatabase() {
        if sqlite3_close(db) == SQLITE_OK {
            print("Database closed")
        } else {
            print("Failed to close database")
        }
        db = nil
    }
    
    deinit {
        closeDatabase()
    }
}
