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
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var menuButton: UIButton!
    
    var circleLocation: CLLocationCoordinate2D?
    var track = Track()
    var zoneManager = ZoneManager.instance
    var overlays: [MKOverlay] = []
    let request = MKDirections.Request()
    let shapeEngine = ShapeEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocation()
        doLayout()
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setCircleLocation()
        
    }
    func doLayout(){
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 15,left: 15,bottom: 15,right: 15)
        menuButton.cornerRadius = 27.5
    }
    func setCircleLocation() {
        for i in 0...zoneManager.zones.count-1{
            let circle = shapeEngine.makeCircle(zone: zoneManager.zones[i])
            mapView.removeOverlays(mapView.overlays)
        
            overlays.append(circle)
        }
        print(overlays)
        mapView.addOverlays(overlays)
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(overlays[0].coordinate.latitude, overlays[0].coordinate.longitude);
    
        myAnnotation.title = zoneManager.zones[0].zoneName
        mapView.addAnnotation(myAnnotation)
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
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let viewRegion = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
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
            circleRenderer.strokeColor = resonancePink
            return circleRenderer
        }else if(overlay is MKPolyline){
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = resonancePink
            renderer.lineWidth = 1
            return renderer
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
        print(view.annotation?.title)
    }
}
extension CALayer {
    func addGradienBorder(colors:[UIColor],width:CGFloat = 1, cornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 1.5, dy: 1.5), byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height:cornerRadius))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: CGPoint.zero, size: self.bounds.size)
        gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y:0.5)
        gradientLayer.colors = colors.map({$0.cgColor})
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.cornerRadius = cornerRadius
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        
        self.insertSublayer(gradientLayer, at: 0)
    }
}

