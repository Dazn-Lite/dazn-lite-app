//
//  LoginViewModel.swift
//  DAZN
//
//  Created by Jakub Malczyk on 13/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: UIControl {
    
    
    
    let usernameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    
    // isValid checks if BOTH email and password are correct
    
    func isValid() -> Observable<Bool> {
       return Observable.combineLatest(usernameTextPublishSubject.asObservable().startWith(""), passwordTextPublishSubject.asObservable().startWith("")).map {
            username , password in
           return username.isValidEmail && password.isValidPassword
        }.startWith(false)
    }
     
    //isEmailValid checks if email is valid
    
    func isEmailValid() -> Observable<Bool> {
        
        return Observable.combineLatest(usernameTextPublishSubject.asObservable().startWith(""), passwordTextPublishSubject.asObservable().startWith("")).map {
            username , password in
           return !username.isValidEmail && boolValEmail == true
        }.startWith(false)
        
        
    }
    
    
    //checks if password is valid
    
    func isPasswordValid() -> Observable<Bool> {
        
       return Observable.combineLatest(usernameTextPublishSubject.asObservable().startWith(""), passwordTextPublishSubject.asObservable().startWith("")).map {
            username , password in
           return !password.isValidPassword && boolValPassword == true
        }.startWith(false)
    }
    
// INITIALIZATION
    var email = ""
    var password = ""
    
    convenience init(email : String, password : String) {
        self.init()
        self.email = email
        self.password = password
    }
    
    
}


extension String {
var isValidEmail: Bool {
    
    
    NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}").evaluate(with: self)
  
    
  
}
var isValidPassword: Bool {
  NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(.*[A-Z0-9a-z._%+-]).{5,}$").evaluate(with: self)
}
}

