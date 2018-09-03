//
//  MemoFromVC.swift
//  PersonalMemo
//
//  Created by Jo JANGHUI on 2018. 9. 3..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import AVFoundation

class MemoFromVC: UIViewController {
    
    var subject: String!
    
    //MARK: - IBOutlet
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    //MARK: - viewDidLoad
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil,
                                          message: "내용을 입력해주세요",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController( title: nil,
                                       message: "이미지 가져올 곳을 선택해주세요",
                                       preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "카메라",
                                   style: .default) { [weak self] (action) in
                                    guard let strongSelf = self else { return }
                                    
                                    let status = AVCaptureDevice.authorizationStatus(for: .video)
                                    switch status {
                                    case .denied:   // 셋팅에서 접근 권한을 껐을때
                                        let settingAlert = UIAlertController(
                                            title: "카메라에 접근권한이 없습니다",
                                            message: "설정 > PersonalMemo에서 카메라를 활성화해주세요",
                                            preferredStyle: .alert)
                                        let showSetting = UIAlertAction(
                                            title: "설정",
                                            style: .default,
                                            handler: { (action) in
                                                guard let settingURL = URL(
                                                    string: UIApplicationOpenSettingsURLString),
                                                    UIApplication.shared.canOpenURL(settingURL)
                                                    else { return }
                                                if #available(iOS 10.0, *) {
                                                    UIApplication.shared.open(settingURL)
                                                } else {
                                                    UIApplication.shared.canOpenURL(settingURL)
                                                }
                                        })
                                        let cancel = UIAlertAction(
                                            title: "확인",
                                            style: .cancel,
                                            handler: nil)
                                        
                                        for alert in [showSetting, cancel] {
                                            settingAlert.addAction(alert)
                                        }
                                        
                                        strongSelf.present(
                                            settingAlert,
                                            animated: true,
                                            completion: nil)
                                    default:
                                        guard UIImagePickerController.isSourceTypeAvailable(.camera)
                                            else { return }
                                        picker.sourceType = .camera
                                        picker.allowsEditing = true
                                        strongSelf.present(picker, animated: true)
                                    }
        }
        
        let saveAlbum = UIAlertAction(title: "저장앨범",
                                      style: .default) { (action) in
            guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
                else { return }
            // 선택한 사진 및 이미지를 수정
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = true
            // 이미지 피커 화면 표시
            self.present(picker, animated:  false)
        }
        
        let photoLibrary = UIAlertAction(title: "사진 라이브러리",
                                         style: .default) { (action) in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
                else { return }
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }
        
        for action in [camera, saveAlbum, photoLibrary] {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        contents.delegate = self
        
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MemoFromVC : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // 선택된 이미지를 미리보기에 표시
        self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: true)
    }
}

extension MemoFromVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
}

// MARK: - UINavigationControllerDelegate
extension MemoFromVC : UINavigationControllerDelegate {
    
}
