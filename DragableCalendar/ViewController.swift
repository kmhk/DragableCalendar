//
//  ViewController.swift
//  DragableCalendar
//
//  Created by com on 8/8/20.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit
import JZCalendarWeekView

class ViewController: UIViewController {
    
    var events = [AllDayEvent]()
    
    let calendarView = CalendarCollectionView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Event Calendar"
        
        let mnuItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(mnuBarButtonTapped(_:)))
        navigationItem.rightBarButtonItem = mnuItem
        
        view.addSubview(calendarView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        initializeData()
        setupCalendarView()
    }
    
    
    // MARK: action
    
    @objc func mnuBarButtonTapped(_ sender: Any) {
        EventMenuView.show(self)
    }


    // MARK: private method
    
    private func initializeData() {
        var date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
        events.append(AllDayEvent(id: "0", title: "event1", startDate: date, endDate: date.addingTimeInterval(3600), location: "", isAllDay: false))
        
        date = Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!
        events.append(AllDayEvent(id: "1", title: "event2", startDate: date, endDate: date.addingTimeInterval(3600), location: "", isAllDay: false))

        date = Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!
        events.append(AllDayEvent(id: "2", title: "event3", startDate: date, endDate: date.addingTimeInterval(3600), location: "", isAllDay: false))
    }
    
    
    private func setupCalendarView() {
        calendarView.frame = view.bounds
        calendarView.baseDelegate = self
        
        let allEvents = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
        
        calendarView.setupCalendar(numOfDays: 3,
                                   setDate: Date(),
                                   allEvents: allEvents,
                                   scrollType: .pageScroll,
                                   scrollableRange: (nil, nil))

        // Optional
        calendarView.addNewDurationMins = 120
        calendarView.moveTimeMinInterval = 15
    }
    
}


// MARK: -
extension ViewController: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        
    }
    
}
