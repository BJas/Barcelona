//
//  NewsDetailCommentTableViewCell.swift
//  BarcelonaApp
//
//  Created by Apple on 08.11.17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsDetailCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var commentTitle: UILabel!
    var id: String = "";
    var name: String = "";
    var commentDesc: String = "";
    

    @IBAction func addComment(_ sender: Any) {
        if (nameField.text != "" && descriptionField.text != ""){
        var rootRef: DatabaseReference! = nil
        name = nameField.text!;
        commentDesc = descriptionField.text;
        rootRef = Database.database().reference()
        let itemsRef = rootRef.child("news")
        let key = itemsRef.child("comments").childByAutoId().key;
        itemsRef.child(id).child("comments").child(key).setValue(["id": key, "name" : name,"commentDesc" : commentDesc])
        nameField.text = "";
        descriptionField.text = "";
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
