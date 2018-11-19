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
    var circle = MKCircle()
    var fakeCircleLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 53.21168578930956, longitude: 5.798549807569524)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        mapView.delegate = self
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setCircleOnUserLocation()
    }
    func setCircleOnUserLocation() {
        let region = CLCircularRegion(center: fakeCircleLocation, radius: 5, identifier: "geofence")
        mapView.removeOverlays(mapView.overlays)
        locationManager.startMonitoring(for: region)
        circle = MKCircle(center: fakeCircleLocation, radius: region.radius)
        mapView.addOverlay(circle)
        
    }
    func checkIfUserIsInZone(locationValue: CLLocationCoordinate2D){
        var zoneLocation: CLLocation = CLLocation(latitude: fakeCircleLocation.latitude, longitude: fakeCircleLocation.longitude)
        
        var userLocation: CLLocation = CLLocation(latitude: locationValue.latitude, longitude: locationValue.longitude)
        
        if userLocation.distance(from: zoneLocation) > circle.radius{
            print("user left zone")
        }else{
            print("user is in zone")
        }
        
    }
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
        
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        checkIfUserIsInZone(locationValue: locValue)
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let circelOverLay = overlay as? MKCircle else {return MKOverlayRenderer()}
        
        let circleRenderer = MKCircleRenderer(circle: circelOverLay)
        circleRenderer.strokeColor = .blue
        circleRenderer.fillColor = .blue
        circleRenderer.alpha = 0.2
        return circleRenderer
    }
}

