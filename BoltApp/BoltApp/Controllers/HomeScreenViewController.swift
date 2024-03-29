//
//  HomeScreenViewController.swift
//  BoltApp
//
//  Created by Mac on 07/10/2022.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation

class HomeScreenViewController: UIViewController, ResultLocationDelegate, SidebarViewControllerDelegate {
    
    let panel = FloatingPanelController()
    
    let sidebarWidth: CGFloat = 250
    
    var sidebarShowing = false
    
    var sidebarViewController = SidebarViewController()
    
    let sideBarButton = Button(image: UIImage(systemName: "text.justify"), label: "", btnTitleColor: .clear, backgroundColor: .clear, radius: 0, imageColor: .black)
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.overrideUserInterfaceStyle = .light
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        setupMapView()
        setupResultVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        mapView.frame = CGRect(x: 0, y: 120, width: view.bounds.width, height: view.bounds.height)
    }
    
    func setupMapView() {
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }
    
    func setupResultVC() {
        let resultVC = ResultLocationViewController()
        resultVC.delegate = self
        panel.set(contentViewController: resultVC)
        panel.addPanel(toParent: self)
    }
    
    func searchViewController(_ vc: ResultLocationViewController, didSelectLocation location: Location) {
        panel.move(to: .tip, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        
        if let coordinates = location.coordinates {
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            
            pin.title = location.name
            
            mapView.addAnnotation(pin)
            
            mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        }
    }
}
