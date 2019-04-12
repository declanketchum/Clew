//
//  DataPersistance.swift
//  Clew
//
//  Created by Khang Vu on 3/14/19.
//  Copyright © 2019 OccamLab. All rights reserved.
//

import Foundation
import ARKit

class DataPersistence {
    
    var routes = [SavedRoute]()

    init() {
        do {
            let data = try Data(contentsOf: self.getRoutesURL())
            self.routes = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [SavedRoute]
        } catch {
            print("couldn't unarchive saved routes")
        }
    }
    
    func archive(route: SavedRoute, worldMap: ARWorldMap?) throws {
        // Save route to the route list
        if !update(route: route) {
            self.routes.append(route)
        }
        let data = try NSKeyedArchiver.archivedData(withRootObject: self.routes, requiringSecureCoding: true)
        try data.write(to: self.getRoutesURL(), options: [.atomic])
        // Save the world map corresponding to the route
        if let worldMapAsAny = worldMap as Any? {
            let data = try NSKeyedArchiver.archivedData(withRootObject: worldMapAsAny, requiringSecureCoding: true)
            try data.write(to: self.getWorldMapURL(id: route.id as String), options: [.atomic])
        }
    }
    
    func unarchive(id: String) -> ARWorldMap? {
        do {
            let data = try Data(contentsOf: getWorldMapURL(id: id))
            guard let unarchivedObject = ((try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data)) as ARWorldMap??),
                let worldMap = unarchivedObject else { return nil }
            return worldMap
        } catch {
            print("Error retrieving world map data.")
            return nil
        }
    }
    
    func update(route: SavedRoute) -> Bool {
        /// Updates the route in the list based on matching ids.  The return value is true if the route was found and updates and false otherwise from the route list
        if let indexOfRoute = routes.firstIndex(where: {$0.id == route.id || $0.name == route.name }) {
            routes[indexOfRoute] = route
            return true
        }
        return false
    }
    
    func delete(route: SavedRoute) throws {
        // Remove route from the route list
        self.routes = self.routes.filter { $0.id != route.id }
        let data = try NSKeyedArchiver.archivedData(withRootObject: self.routes, requiringSecureCoding: true)
        try data.write(to: self.getRoutesURL(), options: [.atomic])
        // Remove the world map corresponding to the route.  We use try? to continue execution even if this fails, since it is not strictly necessary for continued operation
        try? FileManager().removeItem(atPath: self.getWorldMapURL(id: route.id as String).path)
    }
    
    private func getURL(url: String) -> URL {
        return FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(url)
    }
    
    private func getWorldMapURL(id: String) -> URL {
        return getURL(url: id)
    }
    
    private func getRoutesURL() -> URL {
        return getURL(url: "routeList")
    }
    
}