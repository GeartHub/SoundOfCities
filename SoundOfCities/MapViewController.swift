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
    
    @IBOutlet weak var testView: UIView!
    var circleLocation: CLLocationCoordinate2D?
    var package = Package()
    var track = Track()
    var zone = Zone.instance
    var zoneManager = ZoneManager.instance
    var overlays: [MKOverlay] = []
    let request = MKDirections.Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocation()
        testView.layer.addGradienBorder(colors: [resonancePurple,resonanceOrange,resonancePink], width: 4, cornerRadius: 20)
        testView.cornerRadius = 20
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
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(overlays[0].coordinate.latitude, overlays[0].coordinate.longitude);
    
        myAnnotation.title = zoneManager.zones[0].zoneName
        mapView.addAnnotation(myAnnotation)
        setupDirections()
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
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if(overlay is MKCircle){
            let circleRenderer = MKCircleRenderer(circle: overlay as! MKCircle)
//            circleRenderer.strokeColor = resonancePink
            
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
        print("this called")
        
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

