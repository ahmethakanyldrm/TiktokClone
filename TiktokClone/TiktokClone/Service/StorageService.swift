//
//  StorageService.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 3.07.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import ProgressHUD

class StorageService {
    static func savePhoto(username: String, uid:String, data:Data, metaData: StorageMetadata,storageProfileRef: StorageReference ,dict: Dictionary<String,Any>, onSuccess: @escaping() -> Void, onError:@escaping(_ errorMessage:String) -> Void) {
        storageProfileRef.putData(data, metadata: metaData) { _, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
           
            storageProfileRef.downloadURL { url, error in
                if let metaImageUrl = url?.absoluteString {
                    print(metaImageUrl)
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges {error in
                            if let error = error {
                                ProgressHUD.showError(error.localizedDescription)
                            }
                        }
                    }
                    var dictTemp = dict
                    dictTemp["profileImageUrl"] = metaImageUrl
                    Reference().databaseSpesificUser(uid: uid).updateChildValues(dictTemp) { error, _ in
                        if error != nil {
//                                    print(error?.localizedDescription)
                            onError(error?.localizedDescription ?? "Hata var")
                            
                        }else {
                            onSuccess()
                        }
                    }
                }
            }
        }
    }
}

