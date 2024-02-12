//
//  TownhallHomeCoordinator.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 06/02/24.
//

import Foundation
import UIKit

class TownhallHomeCoordinator: ObservableObject {
    @Published var selectedTab: TownhallTab = .aniNews
    @Published var actionTapped: Bool = false
    @Published var refreshNewTab: Bool = false
    private weak var hostingViewController: MasterVC?
    private var townHallParentViewController: UIViewController?
    
    init(hostingViewController: MasterVC) {
        self.hostingViewController = hostingViewController
    }
    
    func showNavigationBar() {
        //hostingViewController?.setupCustomNavigationBar()
        hostingViewController?.navigationController?.navigationBar.isHidden = false
    }
    
    func showLoader() {
        //self.hostingViewController?.showSpinner()
    }
    
    func hideLoader() {
        //self.hostingViewController?.hideSpinner()
    }
    
    func showToast(message: String) {
        //self.hostingViewController?.showMessageToastOnWindow(message: message)
    }
    
    func handleActionTap() {
        actionTapped = true
        hostingViewController?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    func setTownHallParentViewController(_ viewController: UIViewController) {
        townHallParentViewController = viewController
    }
    
    // Add a function to get the TownHallParentViewController if needed
//    func getTownHallParentViewController() -> TownHallParentViewController? {
//        return townHallParentViewController
//    }
    
    func refreshTimeLineData() {
//        townHallParentViewController?.showSpinner()
//        townHallParentViewController?.deleteAndFetch()
//        townHallParentViewController?.lazyLoadingMethod(limit: 20)
    }
    
    func shareAniPost(id: String) {
        guard let vc = hostingViewController else { return }
        //Utility.showActionSheet(on: vc, id: id)
    }
    
    func navigateToProfileVC(userName: String?) {
        guard let uname = userName else { return }
        
//        let userProfileVC = UserProfileVC(userProfileVM: UserProfileViewModel(userProfileProtocaol: UserProfileAbstration()), userName: uname)
//        hostingViewController?.navigationController!.pushViewController(userProfileVC, animated: true)
    }
    
    func openLinkInBrowser(urlString: String?) {
        guard let str = urlString, let url = URL(string: str) else { return }
        
//        let controller = WebBrowserController.showWebView(withURL: url)
//        hostingViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func openDetails(id:String?) {
        guard let postID = id else { return }
//        let postVC = TownHallPostVC(translateLanguageVM: TranslateLangViewModel(translateLanguageProtocol: TranslateLanguageAbstraction()))
//        postVC.postID = postID
//        hostingViewController?.navigationController?.pushViewController(postVC, animated: true)
    }
    
    func openCommentView(post: TownHallPost) {
//        let vc = ReplyPostVC(nibName: "ReplyPostVC", bundle: nil)
//        let modelData = post
//        vc.model = AllData.init(fromDictionary: modelData.convertDict ?? [:])
//        vc.type = .comment
//        vc.postID = modelData.postID
//        hostingViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showLoginPop(title: String = "anonymous", image: UIImage = UIImage(systemName: "hand.thumbsup.fill")!) {
//        hostingViewController?.showLoginPopup(titleI: title, imageI: image)
    }
}
