//
//  ANIServiceEndPoint.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 05/02/24.
//

import Foundation
import UIKit

enum ParameterKeys: String {
    case limit, skip, type
    case pageId = "page_id"
    case prePageId = "pre_page_id"
}

enum ANIServiceEndPoint: NetworkProtocol {
    case newsFeed(skip: Int, prePageId: String)
    case likeDislike(action: String, postId: String)
    
    var baseURL: URL {
        switch self {
            case .likeDislike:
                return URL(string: "https://node.khulke.com/api/post/")!
            default:
                return URL(string: "https://node.khulke.com/")!
        }
    }
    
    var path: String {
        switch self {
            case .newsFeed:
                return "api/townhall/paginate"
            case .likeDislike(let action, let id):
                return "\(id)/\(action)"
        }
        
    }
    
    var method: HTTPMethods {
        switch self {
            default:
                return .post
        }
    }
    
    var headers: [String : String]? {
        switch self {
            default:
                return ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InRqcHFmN2o4eDlwbWIyNCIsIl9pZCI6IjY1YzFlMWUxMmViY2I5NjkyMzQwYTVmNiJ9.KP9rwUvzEHTzBloyK0NYlyTRr_nF7JOjE4jSXf6aODs"]
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
            case .newsFeed(let skip, let prePageId):
                var params = [String: Any]()
                params[ParameterKeys.limit.rawValue] = 20
                params[ParameterKeys.type.rawValue] = "feeds"
                params[ParameterKeys.pageId.rawValue] = ""
                params[ParameterKeys.prePageId.rawValue] = prePageId
                params[ParameterKeys.skip.rawValue] = skip
                return params
            case .likeDislike(let action, let id):
                return ["type": action,
                        "post_id": id,
                        "device_info":  deviceInfoMore]
        }
    }
    
    var deviceInfoMore : [String : Any] {
        var deviceInfo : [String : Any] = [String : Any]()
        deviceInfo[APIConstants.deviceName] = UIDevice.modelName
        deviceInfo[APIConstants.platform] = APIConstants.iOS
        deviceInfo[APIConstants.platformVersion] = UIDevice.current.systemVersion
        deviceInfo[APIConstants.appVersion] = "3.0.3"
        deviceInfo[APIConstants.latitude] =  0
        deviceInfo[APIConstants.longitude] =  0.0
        deviceInfo[APIConstants.ipAddress] = UIDevice.current.getIP() ?? "0.0.0.0"
        deviceInfo[APIConstants.city] = "PNP"
        deviceInfo[APIConstants.state] = "HR"
        deviceInfo[APIConstants.country] = "IND"
        deviceInfo[APIConstants.postCode] = "132103"
        return deviceInfo
    }
}

struct APIConstants {
    static let privacyPolicy = "privacy-policy"
    static let termsConditions = "terms-conditions"
    static let support = "Support"
    static let firebaseToken = "firebaseToken"
    static let firebaseHyphenToken = "firebase-token"
    static let deviceType = "device-type"
    static let deviceId = "device-id"
    static let refreshToken = "refresh_token"
    static let anonymousUserToken = "anonymous_user_token"
    static let accessToken = "access_token"
    static let authorization = "Authorization"
    
    static let screenName = "Pwd_Phone "
    static let forgotPassword = "Forgot Password"
    static let termsOfUse = "Terms of Use"
    static let privacyPolicyString = "Privacy Policy"
    static let phoneNumber = "phone_number"
    static let rType = "r_type"
    static let password = "password"
    static let email = "email"
    static let userData = "user_data"
    static let pwdVerify = "Pwd_Verify"
    static let username = "username"
    static let message = "message"
    static let userSignUp = "User Sign Up"
    static let signUp = "Sign up"
    static let userId = "User_id"
    static let emailVerification = "email_verification"
    static let phoneVerification = "phone_verification"
    static let deviceName = "device_name"
    static let platform = "platform"
    static let platformVersion = "platform_version"
    static let appVersion = "app_version"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let ipAddress = "ip_address"
    static let deviceInfo = "deviceinfo"
    static let iOS = "iOS"
    static let indiaCode = "+91"
    static let limit = "limit"
    static let skip = "skip"
    static let PageNum = "pageNum"
    static let page = "page"
    static let path = "path"
    static let profile = "profile"
    static let firstPost = "firstPost"
    static let postId = "post_id"
    static let handle = "handle"
    static let type = "type"
    static let eventError = "event error"
    static let networkError = "Network error"
    static let error = "error"
    static let townHall = "TownHall"
    static let serverTimeout = "Server Timeout"
    static let snippet = "Snippet"
    static let operationType = "operation_type"
    static let user = "user"
    static let city = "city"
    static let state = "state"
    static let country = "country"
    static let postCode = "post_code"
    
}

public extension UIDevice {
    
    static var isSimulator: Bool = {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }()
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case Unknown
    }
    
    var screenType: ScreenType {
        guard iPhone else { return .Unknown }
        switch UIScreen.main.nativeBounds.height {
            
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    private struct InterfaceNames {
        static let wifi = ["en0"]
        static let wired = ["en2", "en3", "en4"]
        static let cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
        static let supported = wifi + wired + cellular
    }
    /**
     Returns device ip address. Nil if connected via celluar.
     */
    func getIP() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
                guard let interface = ptr?.pointee else {
                    return nil
                }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    guard let ifa_name = interface.ifa_name else {
                        return nil
                    }
                    let name: String = String(cString: ifa_name)
                    if name == "en0" {  // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                       return "iPod touch (5th generation)"
            case "iPod7,1":                                       return "iPod touch (6th generation)"
            case "iPod9,1":                                       return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
            case "iPhone4,1":                                     return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
            case "iPhone7,2":                                     return "iPhone 6"
            case "iPhone7,1":                                     return "iPhone 6 Plus"
            case "iPhone8,1":                                     return "iPhone 6s"
            case "iPhone8,2":                                     return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
            case "iPhone11,2":                                    return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
            case "iPhone11,8":                                    return "iPhone XR"
            case "iPhone12,1":                                    return "iPhone 11"
            case "iPhone12,3":                                    return "iPhone 11 Pro"
            case "iPhone12,5":                                    return "iPhone 11 Pro Max"
            case "iPhone13,1":                                    return "iPhone 12 mini"
            case "iPhone13,2":                                    return "iPhone 12"
            case "iPhone13,3":                                    return "iPhone 12 Pro"
            case "iPhone13,4":                                    return "iPhone 12 Pro Max"
            case "iPhone14,4":                                    return "iPhone 13 mini"
            case "iPhone14,5":                                    return "iPhone 13"
            case "iPhone14,2":                                    return "iPhone 13 Pro"
            case "iPhone14,3":                                    return "iPhone 13 Pro Max"
            case "iPhone14,7":                                    return "iPhone 14"
            case "iPhone14,8":                                    return "iPhone 14 Plus"
            case "iPhone15,2":                                    return "iPhone 14 Pro"
            case "iPhone15,3":                                    return "iPhone 14 Pro Max"
            case "iPhone8,4":                                     return "iPhone SE"
            case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
            case "iPhone14,6":                                    return "iPhone SE (3rd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad13,18", "iPad13,19":                        return "iPad (10th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad14,3", "iPad14,4":                          return "iPad Pro (11-inch) (4th generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "iPad14,5", "iPad14,6":                          return "iPad Pro (12.9-inch) (6th generation)"
            case "AppleTV5,3":                                    return "Apple TV"
            case "AppleTV6,2":                                    return "Apple TV 4K"
            case "AudioAccessory1,1":                             return "HomePod"
            case "AudioAccessory5,1":                             return "HomePod mini"
            case "i386", "x86_64", "arm64":                       return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()
}
