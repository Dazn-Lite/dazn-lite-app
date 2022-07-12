//
//  ViewController.swift
//  DAZN
//
//  Created by Jakub Malczyk on 12/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

var boolValEmail = false
var boolValPassword = false

class ViewController: UIViewController {

    let loginLabel = UILabel()
    let loginButton = UIButton()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginFieldLine = UIView()
    let passwordFieldLine = UIView()
    let eyeButton = UIButton()
    var showPassword = false
    
    
    private let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    // animationsValues
    
    var textFieldOnPosition : CGFloat = 299
    var textFIeldOffPosition : CGFloat = 279
    var loginTextFieldTopAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginHeaderSetup()
        buttonSetup()
        loginFieldSetup()
        passwordFieldSetup()
        underlinesSetup()
        eyeButtonSetup()
        
        view.backgroundColor = UIColor(named: "Tarmac")
        
    
        loginTextField.becomeFirstResponder()
        
        //Starting the Reactive publishing for both the Email and Password fields. Connecting them with "loginViewModel" so they can be published as events there.
        loginTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.usernameTextPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)
        
        
        //Uncovering the login button when BOTH EMAIL and PASSWORD are valid.
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.2}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
        
        
        //Setting the one time bool value to true when user stops editing the Email or Password for the first time.
        //Thanks to that, user isn't notified abour wrong password at the moment of beggining of filling the form.
        loginTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext:{ boolValEmail = true})
        passwordTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext:{ boolValPassword = true})
        
        loginTextField.rx.controlEvent([.editingDidBegin]).subscribe(onNext:{ boolValEmail = false})
        passwordTextField.rx.controlEvent([.editingDidBegin]).subscribe(onNext:{ boolValPassword = false})
        
        /*
         
         TO ZROBIC JAK BEDA CZERWONE PRZYPOMINACZE O ZLYM HASLE I ZLYM LOGINIE!!
         
        //Setting the "INCORRECT EMAIL" and "INCORRECT PASSWORD" Red Labels Invisible and visible depending on the "isEmailValid" and "isPasswordValid"
        loginViewModel.isEmailValid().map {$0 ? 1 : 0.01 }.bind(to: incorrectEmail.rx.alpha).disposed(by: disposeBag)
        loginViewModel.isPasswordValid().map {$0 ? 1 : 0.01 }.bind(to: incorrectPassword.rx.alpha).disposed(by: disposeBag)
    
        */
    }
       
}



extension ViewController{
    private func loginHeaderSetup(){
        view.addSubview(loginLabel)
        loginLabel.text = "LOGIN"
        loginLabel.textColor = UIColor(named: "Chalk")
        
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 166).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -166).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    private func buttonSetup(){
        view.addSubview(loginButton)
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = UIColor(named: "Neon")
        loginButton.setTitleColor(UIColor(named: "Concrete"), for: .normal)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -39).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 730).isActive = true
    }
    
    private func loginFieldSetup(){
        view.addSubview(loginTextField)
        
        loginTextField.backgroundColor = .clear
        loginTextField.textColor = UIColor(named: "Chalk")
        loginTextField.attributedPlaceholder = NSAttributedString(
            string: "E-mail address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Chalk")!]
        )
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -220).isActive = true
        //loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: textFieldOnPosition).isActive = true
        loginTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -489).isActive = true
        
        loginTextFieldTopAnchor = loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: textFieldOnPosition)
        loginTextFieldTopAnchor?.isActive = true
            
    }
    
    
    private func passwordFieldSetup(){
        view.addSubview(passwordTextField)
        
        passwordTextField.backgroundColor = .clear
        passwordTextField.textColor = UIColor(named: "Chalk")
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Chalk")!]
        )
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -220).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -388).isActive = true
    }
    
    private func underlinesSetup(){
        view.addSubview(loginFieldLine)
        view.addSubview(passwordFieldLine)
        loginFieldLine.backgroundColor = UIColor(named: "Chalk")
        passwordFieldLine.backgroundColor = UIColor(named: "Chalk")
        
        loginFieldLine.translatesAutoresizingMaskIntoConstraints = false
        loginFieldLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        loginFieldLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        loginTextField.bottomAnchor.constraint(equalTo: loginFieldLine.topAnchor, constant: -1).isActive = true
        loginFieldLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordFieldLine.translatesAutoresizingMaskIntoConstraints = false
        passwordFieldLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        passwordFieldLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordFieldLine.topAnchor, constant: -1).isActive = true
        passwordFieldLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func eyeButtonSetup(){
        view.addSubview(eyeButton)
        
        eyeButton.setTitle("", for: .normal)
        eyeButton.setImage(UIImage(systemName:"eye"), for: .normal)
        eyeButton.tintColor = UIColor(named: "Chalk")
        eyeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 329).isActive = true
        eyeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26).isActive = true
        eyeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 405).isActive = true
        eyeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -393).isActive = true
        
    }
    
    @objc func buttonTapped(){
            animateTextField()
//        passwordTextField.isSecureTextEntry.toggle()
//        self.showPassword.toggle()
//        print(showPassword)
    }
    
    
    func animateTextField(){
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut){
            self.loginTextFieldTopAnchor?.constant = self.textFIeldOffPosition
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }

    @IBDesignable
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
}

extension String {
    var isValidEmail: Bool {
        
        
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}").evaluate(with: self)
      
        
      
    }
    var isValidPassword: Bool {
      NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(.*[A-Z0-9a-z._%+-]).{5,}$").evaluate(with: self)
    }
}
