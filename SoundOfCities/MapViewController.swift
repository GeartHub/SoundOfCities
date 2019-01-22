//
//  MapViewController.swift
//  SoundOfCities
//
//  Created by Geart Otten on 13/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//
//5,79855
import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
   private var locationManager: CLLocationManager!
    
    @IBOutlet weak var menuView: UIStackView!
    
//    @IBOutlet weak var menuButton: UIButton!
    
    var circleLocation: CLLocationCoordinate2D?
    var track = Track()
    var zoneManager = ZoneManager.instance
    var overlays: [MKOverlay] = []
    var annotationArray: [MKAnnotation] = []
    let request = MKDirections.Request()
    let shapeEngine = ShapeEngine()
    let playerPool = AVAudioPlayerPool.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        print(zoneManager.zones.count)
        
        setupLocation()
//        doLayout()
    }
 

    func doLayout(){
        let safeArea = self.view.safeAreaLayoutGuide
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
//        addButtons()
        let menuButtonTypes: [MenuButtonType] = [.tracked, .camera, .hike, .navigation, .menu]
        
        for type in menuButtonTypes{
            let button = MenuButton(type: type)
            stackView.addArrangedSubview(button)
        }
        stackView.layoutIfNeeded()
        stackView.spacing = 15
        
        
    }
    func addButtons(){
        

    }
    func setupLocation(){
        DispatchQueue.main.async {
            
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.setCircleOnLocation()
        }
        
        
    }
    func setCircleOnLocation() {
        for i in 0...zoneManager.zones.count-1{
            let circle = shapeEngine.makeCircle(zone: zoneManager.zones[i])
            mapView.removeOverlays(mapView.overlays)
        
            overlays.append(circle)
            
            
            
        }
        for hotspot in zoneManager.hotspots{
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.title = hotspot.name
            myAnnotation.coordinate = hotspot.location!
            annotationArray.append(myAnnotation)
        }
        mapView.addOverlays(overlays)
        mapView.addAnnotations(annotationArray)
    }
    
    func setupDirections() {
        request.source =  MKMapItem(placemark: MKPlacemark(coordinate: (locationManager.location?.coordinate)!, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: overlays[0].coordinate.latitude, longitude: overlays[0].coordinate.longitude), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HotspotInformationScreen", let destination = segue.destination as? HotspotInformationScreenViewController{
            destination.hotspot = (sender as! Hotspot)
        }
    }
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let viewRegion = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(viewRegion, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        track.play(name: region.identifier)
        print(region.identifier , " has been entered")
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        track.stop(name: region.identifier)
        print(region.identifier , " has been exited")
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if(overlay is MKCircle){
            let circleRenderer = MKCircleRenderer(circle: overlay as! MKCircle)
            circleRenderer.strokeColor  = resonancePink
            return circleRenderer
        }else if(overlay is MKPolyline){
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = resonancePink
            renderer.lineWidth = 1
            return renderer
        }else if (overlay is MKPolygon){
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.strokeColor = resonancePink
        }
        return MKOverlayRenderer()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: "test")
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: "test")
            anView?.canShowCallout = true
            anView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            anView?.image = UIImage(named: "marker")

        }else {
            anView?.annotation = annotation
        }
        return anView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "HotspotInformationScreen", sender: zoneManager.find(with: ((view.annotation?.title!)!)))
    }
}


