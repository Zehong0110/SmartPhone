//
//  ChatViewController.swift
//  LoginApp
//
//  Created by 沈泽洪 on 12/8/20.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Sender:SenderType{
    var senderId: String
    var displayName: String
}

struct Message: MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}


class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate,MessagesDisplayDelegate,InputBarAccessoryViewDelegate {
  
    let currentUser=Sender(senderId:"self", displayName: "Zehong Shen")
    let otherUser=Sender(senderId:"other", displayName: "Ashish Ashish")
    
    let imageNames=["F", "M"]
    
    var messages = [MessageType]()
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType,
        at indexPath: IndexPath) -> NSAttributedString? {

        let name = message.sender.displayName
        return NSAttributedString(
          string: name,
          attributes: [
            .font: UIFont.preferredFont(forTextStyle: .caption1),
            .foregroundColor: UIColor(white: 0.3, alpha: 1)
          ]
        )
      }
    
    
    private func insertNewMessage(_ message: Message) {
    messages.append(message)
    messagesCollectionView.reloadData()
    DispatchQueue.main.async {
    self.messagesCollectionView.scrollToBottom(animated: true)
    }
    }

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let content=inputBar.inputTextView.text
        let message = Message(sender: currentUser, messageId: UUID().uuidString, sentDate: Date(), kind: .text(content!))
                      insertNewMessage(message)
                      inputBar.inputTextView.text = ""
                      messagesCollectionView.reloadData()
                      messagesCollectionView.scrollToBottom(animated: true)
                }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
            
        if message.sender.senderId == currentUser.senderId{
                avatarView.image = UIImage(named:imageNames[0])
            }
        else{
                avatarView.image = UIImage(named:imageNames[1])
            }
        }
   
    //try to show the keyboard but didn't work.
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }

    }

    func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(Message(sender:currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-90000), kind: .text("Hello Professor")))
        messages.append(Message(sender:otherUser,messageId: "2",sentDate: Date().addingTimeInterval(-80000), kind: .text("Hello Zehong")))
        messages.append(Message(sender:currentUser,messageId: "3",sentDate: Date().addingTimeInterval(-70000),kind: .text("How are you doing")))
        messages.append(Message(sender:otherUser,messageId: "4",sentDate: Date().addingTimeInterval(-50000), kind: .text("I'm doing Okay")))
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource=self
        messagesCollectionView.messagesLayoutDelegate=self
        messagesCollectionView.messagesDisplayDelegate=self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
