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
    
    
    

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    

    //header
    let headerLabel = UILabel()
    
    // login & password
    let loginTextField = UITextField()
    let loginLabel = UILabel()
    let loginFieldLine = UIView()
    let passwordTextField = UITextField()
    let passwordLabel = UILabel()
    let passwordFieldLine = UIView()
    let eyeButton = UIButton()
    let loginButton = UIButton()
    let incorrectLoginLabel = UILabel()
    let incorrectPasswordLabel = UILabel()
    
    private let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    // animationsValues
    
    var loginOnPosition : CGFloat = 299
    var loginOffPosition : CGFloat = 269
    var loginTextFieldTopAnchor: NSLayoutConstraint?
    
   
    
    var passwordOnPosition : CGFloat = 400
    var passwordOffPosition : CGFloat = 385
    var passwordTextFieldTopAnchor : NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginHeaderSetup()
        buttonSetup()
        loginFieldSetup()
        passwordFieldSetup()
        underlinesSetup()
        eyeButtonSetup()
        setupRx()
        view.backgroundColor = Color.Tarmac.getColor
    }
      
}


// MARK: Layout & Style

extension ViewController{
    private func loginHeaderSetup(){
        view.addSubview(headerLabel)
        headerLabel.text = "LOGIN"
        headerLabel.textColor = Color.Chalk.getColor
        headerLabel.font = UIFont(name: "DAZNTrim-Bold", size: 22)
        
        

        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true


    }
    
    
    private func buttonSetup(){
        view.addSubview(loginButton)
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel!.font = UIFont(name: "DAZNTrim-Bold", size: 22)
        loginButton.setTitleColor(Color.Asphalt.getColor, for: .normal)
    
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func loginFieldSetup(){
        view.addSubview(loginTextField)
        view.addSubview(loginLabel)
        
        loginLabel.text = "E-mail address"
        loginLabel.font = UIFont(name: "DAZNOscine-Regular", size: 16)
        loginLabel.textColor = Color.Chalk.getColor
        
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -220).isActive = true

        // animation
        loginTextFieldTopAnchor = loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: loginOnPosition)
        loginTextFieldTopAnchor?.isActive = true
        //
        
        
        
        loginTextField.backgroundColor = .clear
        loginTextField.textColor = Color.Chalk.getColor
     
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: loginOnPosition).isActive = true
        //loginTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -489).isActive = true
        
        
        
        view.addSubview(incorrectLoginLabel)
        incorrectLoginLabel.text = "Incorrect Email"
        incorrectLoginLabel.textColor = Color.GlovesLight.getColor
        incorrectLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectLoginLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        incorrectLoginLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        incorrectLoginLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20).isActive = true
        

    }
    
    
    private func passwordFieldSetup(){
        view.addSubview(passwordTextField)
        view.addSubview(passwordLabel)
        
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "DAZNOscine-Regular", size: 16)
        passwordLabel.textColor = Color.Chalk.getColor
        
        passwordTextField.font = UIFont(name: "DAZNOscine-Regular", size: 16)
        // passwordTextField.textColor = .red do poprawy
        passwordTextField.backgroundColor = .clear
        passwordTextField.textColor = Color.Chalk.getColor
        passwordTextField.isSecureTextEntry = true
       
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30).isActive = true
        
        // animation
        passwordTextFieldTopAnchor = passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: passwordOnPosition)
        passwordTextFieldTopAnchor?.isActive = true
    
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: passwordOnPosition).isActive = true

        //  Warning label
        view.addSubview(incorrectPasswordLabel)
        incorrectPasswordLabel.text = "Incorrect Password"
        incorrectPasswordLabel.textColor = Color.GlovesLight.getColor
        incorrectPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        incorrectPasswordLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        incorrectPasswordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        incorrectPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        
        
    }
    
    private func underlinesSetup(){
        view.addSubview(loginFieldLine)
        view.addSubview(passwordFieldLine)
        loginFieldLine.backgroundColor = Color.Chalk.getColor
        passwordFieldLine.backgroundColor = Color.Chalk.getColor
        
        loginFieldLine.translatesAutoresizingMaskIntoConstraints = false
        loginFieldLine.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        loginFieldLine.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        loginTextField.bottomAnchor.constraint(equalTo: loginFieldLine.topAnchor, constant: -3).isActive = true
        loginFieldLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordFieldLine.translatesAutoresizingMaskIntoConstraints = false
        passwordFieldLine.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        passwordFieldLine.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordFieldLine.topAnchor, constant: -3).isActive = true
        passwordFieldLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func eyeButtonSetup(){
        view.addSubview(eyeButton)
        
        eyeButton.setTitle("", for: .normal)
        eyeButton.setImage(UIImage(systemName:"eye"), for: .normal)
        eyeButton.setImage(UIImage(systemName:"checkmark"), for: .selected)
        eyeButton.contentMode = .scaleAspectFit
        eyeButton.tintColor = Color.Chalk.getColor
        eyeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
//        eyeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 329).isActive = true
        eyeButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        eyeButton.bottomAnchor.constraint(equalTo: passwordFieldLine.topAnchor, constant: -3).isActive = true
        
    }
    
    @objc func buttonTapped(_ sender: Any){
        eyeButton.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
        print(getHeight())
    }
    
    @objc func loginTapped(){
      
    }
}
    
 


// MARK:  - Animations

extension ViewController{
    
    func startTypingLogin(){
        let animation = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut){
            self.loginTextFieldTopAnchor?.constant = self.loginOffPosition
            self.loginLabel.font = UIFont(name: "DAZNOscine-Bold", size: 14)
            self.loginLabel.textColor = Color.Concrete.getColor
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
    }
    
    func finishTypingLogin(){
        let animation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut){
            self.loginTextFieldTopAnchor?.constant = self.loginOnPosition
            self.loginLabel.font = UIFont(name: "DAZNOscine-Regular", size: 16)
            self.loginLabel.textColor = Color.Chalk.getColor
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
    }
    
    
    func startTypingPassword(){
        let animation = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut){
            self.passwordTextFieldTopAnchor?.constant = self.passwordOffPosition
            self.passwordLabel.font = UIFont(name: "DAZNOscine-Bold", size: 14)
            self.passwordLabel.textColor = Color.Concrete.getColor
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
    }
        
    func finishTypingPassword(){
        let animation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut){
            self.passwordTextFieldTopAnchor?.constant = self.passwordOnPosition
            self.passwordLabel.font = UIFont(name: "DAZNOscine-Regular", size: 16)
            self.passwordLabel.textColor = Color.Chalk.getColor
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
    }
}
// MARK: RX

extension ViewController{
    func setupRx(){
        
            //loginTextField.becomeFirstResponder()
            
            //Starting the Reactive publishing for both the Email and Password fields. Connecting them with "loginViewModel" so they can be published as events there.
            loginTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.usernameTextPublishSubject).disposed(by: disposeBag)
            passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)
            
            //Uncovering the login button when BOTH EMAIL and PASSWORD are valid.
            loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
            loginViewModel.isValid().map {$0 ? Color.Neon.getColor : Color.Mako.getColor }.bind(to: loginButton.rx.backgroundColor).disposed(by: disposeBag)
        
        //loginViewModel.isValid().subscribe(onNext:{_ in loginButton.rx.setTitleColor(.yellow, for: .normal,})
       
        
    
       
//        loginViewModel.isValid().map {$0 ? Color.Asphalt.getColor : Color.Asphalt.getColor }.bind(to: loginButton).disposed(by: disposeBag)
        
            
            //Setting the one time bool value to true when user stops editing the Email or Password for the first time.
            //Thanks to that, user isn't notified abour wrong password at the moment of beggining of filling the form.
            loginTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext:{ boolValEmail = true})
            passwordTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext:{ boolValPassword = true})
            
            loginTextField.rx.controlEvent([.editingDidBegin]).subscribe(onNext:{
                boolValEmail = false
                self.startTypingLogin()
            })
            passwordTextField.rx.controlEvent([.editingDidBegin]).subscribe(onNext:{
                boolValPassword = false
                self.startTypingPassword()
            })
            
        loginTextField.rx.controlEvent([.editingDidEnd]).subscribe(onNext:{ [self] in
                boolValEmail = true
                
                guard let text = loginTextField.text, !text.isEmpty else{
                        
                self.finishTypingLogin()
                    return
                }
            })
            passwordTextField.rx.controlEvent([.editingDidEnd]).subscribe(onNext:{ [self] in
                boolValPassword = true
                guard let text = passwordTextField.text, !text.isEmpty else{
                self.finishTypingPassword()
                    return
                }
            })
            
           
       
          
             
            //Setting the "INCORRECT EMAIL" and "INCORRECT PASSWORD" Red Labels Invisible and visible depending on the "isEmailValid" and "isPasswordValid"
            loginViewModel.isEmailValid().map {$0 ? 1 : 0.01 }.bind(to: incorrectLoginLabel.rx.alpha).disposed(by: disposeBag)
            loginViewModel.isPasswordValid().map {$0 ? 1 : 0.01 }.bind(to: incorrectPasswordLabel.rx.alpha).disposed(by: disposeBag)
        //
         
            
            loginViewModel.isEmailValid().map {$0 ? Color.GlovesLight.getColor : Color.Chalk.getColor }.bind(to: loginFieldLine.rx.backgroundColor).disposed(by: disposeBag)
            loginViewModel.isPasswordValid().map {$0 ? Color.GlovesLight.getColor : Color.Chalk.getColor }.bind(to: passwordFieldLine.rx.backgroundColor).disposed(by: disposeBag)
    }
}
    
    
