import Foundation
import Security

class KeychainHelper {
    static func saveAccessToken(token: String) -> Bool {
        return saveString(key: "access_token", value: token)
    }
    
    static func loadAccessToken() -> String? {
        return loadString(key: "access_token")
    }
    
    static func deleteAccessToken() -> Bool {
        return deleteString(key: "access_token")
    }
    
    private static func saveString(key: String, value: String) -> Bool {
        if let data = value.data(using: .utf8) {
            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ]
            
            SecItemDelete(query as CFDictionary)
            
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
        }
        return false
    }
    
    private static func loadString(key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue!
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data, let loadedString = String(data: data, encoding: .utf8) {
            return loadedString
        } else {
            return nil
        }
    }
    
    private static func deleteString(key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
