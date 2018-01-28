//
//  HomeVC.swift
//  savus
//
//  Created by Krishna  Madireddy on 1/28/18.
//  Copyright © 2018 Krishna  Madireddy. All rights reserved.
//

import UIKit
import UserNotifications
import MapKit
import Contacts

class HomeVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func notifyPressed(_ sender: Any)
    {
        timedNotification(inSeconds: 10) { (success) in
            if success {
                print("Successfully Notified")
            }
        }
    }
    
    func timedNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> ()) {
        
        guard let imageURL = Bundle.main.url(forResource: "harvey", withExtension: "jpg") else {
            completion(false)
            return
        } //change gif name
        
        let attachment = try! UNNotificationAttachment(identifier: "harvey", url: imageURL, options: .none)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "#hurricaneHarvey"
        content.subtitle = "RESCUE mission near you!"
        content.body = "Kingwood, TX, 77325- family of 6 and pet dog; need extra vehicle to evacuate."
        content.attachments = [attachment]
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                completion(true)
            }else {
                completion(false)
            }
        }
    }
    
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBAction func logoutPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error == nil {
                print("Authorization Successfull")
            }
        }
        
        blurView.layer.cornerRadius = 15
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 0.7
        sideView.layer.shadowOffset = CGSize (width: 5, height: 0)
        
        viewConstraint.constant = -375
        
        //let initialLocation = CLLocation(latitude: 30.6117331, longitude: -96.341)
        //let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, 1000, 1000)
        let span = MKCoordinateSpanMake(0.050, 0.050)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.611, longitude: -96.341), span: span )
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        let mock = Distress(name: "@AnshuRao14", severity: "#critical", coordinate: CLLocationCoordinate2D(latitude: 30.63, longitude: -96.35))
        mapView.addAnnotation(mock)
        let mock2 = Distress(name: "@MRTZA", severity: "#supplies", coordinate: CLLocationCoordinate2D(latitude: 30.66, longitude: -96.32))
        mapView.addAnnotation(mock2)
        let mock3 = Distress(name: "@Suryaaa", severity: "#rescue", coordinate: CLLocationCoordinate2D(latitude: 30.61, longitude: -96.33))
        mapView.addAnnotation(mock3)
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
    }
    
    @IBAction func panPerform(_ sender: UIPanGestureRecognizer)
    {
        if sender.state == .began || sender.state == .changed
        {
            let translation = sender.translation(in: self.view).x
            
            if translation > 0 //swipe right
            {
                if viewConstraint.constant < 20
                {
                    UIView.animate(withDuration: 0.2, animations:
                    {
                        self.viewConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    })
                }
            }
            else //swipe left
            {
                if viewConstraint.constant > -375
                {
                    UIView.animate(withDuration: 0.2, animations:
                        {
                            self.viewConstraint.constant += translation / 10
                            self.view.layoutIfNeeded()
                    })
                }
            }
        }
        else if sender.state == .ended
            {
                if viewConstraint.constant < -100
                {
                    UIView.animate(withDuration: 0.2, animations:
                        {
                            self.viewConstraint.constant = -375
                            self.view.layoutIfNeeded()
                    })
                }
            }
            
            else
        {
            UIView.animate(withDuration: 0.2, animations:
                {
                    self.viewConstraint.constant = 0
                    self.view.layoutIfNeeded()
            })
            }
        }
    }

extension UIViewController: MKMapViewDelegate{
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Distress else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
    
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! Distress
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}


