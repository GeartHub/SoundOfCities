//
//  MapViewController.swift
//  SoundOfCities
//
//  Created by Geart Otten on 13/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    var circleLocation: CLLocationCoordinate2D?
    var package = Package()
    var track = Track()
    var zone = Zone.instance
    var zoneManager = ZoneManager.instance
    var overlays: [MKOverlay] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocation()
        
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setCircleLocation()
    }
    func setCircleLocation() {
        for i in 0...zoneManager.zones.count-1{
            var circle = MKCircle()
            circleLocation = CLLocationCoordinate2D(latitude: zoneManager.zones[i].latitude!, longitude: zoneManager.zones[i].longitude!)
            let region = CLCircularRegion(center: circleLocation!, radius: zoneManager.zones[i].radius!, identifier: zoneManager.zones[i].zoneName!)
            region.notifyOnEntry = true
            region.notifyOnExit = true
            mapView.removeOverlays(mapView.overlays)
            locationManager.startMonitoring(for: region)
            circle = MKCircle(center: circleLocation!, radius: region.radius)
        
            overlays.append(circle)
        }
        mapView.addOverlays(overlays)
        
    }
    func checkIfUserIsInZone(locationValue: CLLocationCoordinate2D){
        var zoneLocation: CLLocation = CLLocation(latitude: zoneManager.zones[1].latitude!, longitude: zoneManager.zones[1].longitude!)
//
        var userLocation: CLLocation = CLLocation(latitude: locationValue.latitude, longitude: locationValue.longitude)
//
        
    }
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
        print("test")
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        checkIfUserIsInZone(locationValue: locValue)
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        track.play(name: region.identifier)
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        guard let circelOverLay = overlay as? MKCircle else {return MKOverlayRenderer()}
        
        if(overlay is MKCircle){
            let circleRenderer = MKCircleRenderer(circle: overlay as! MKCircle)
            circleRenderer.strokeColor = UIColor.magenta
            circleRenderer.lineWidth = 4
//            circleRenderer.fillColor = UIColor.magenta
            circleRenderer.alpha = 0.5
            return circleRenderer
        }
        return MKOverlayRenderer()
    }
}

