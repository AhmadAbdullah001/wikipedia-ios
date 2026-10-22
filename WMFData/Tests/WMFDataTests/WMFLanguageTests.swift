import XCTest
@testable import WMFData

final class WMFLanguageTests: XCTestCase {

    func testLocalizedNameDistinguishesChineseVariants() {
        let variantCodes = ["zh-Hant-TW", "zh-Hant-HK", "zh-Hans-CN"]
        let languages = variantCodes.map {
            WMFLanguage(languageCode: "zh", languageVariantCode: $0)
        }

        let localizedNames = languages.map(\.localizedName)

        XCTAssertEqual(Set(localizedNames).count, variantCodes.count)
        for (localizedName, variantCode) in zip(localizedNames, variantCodes) {
            guard let expectedName = Locale.current.localizedString(forIdentifier: variantCode) else {
                XCTFail("Expected a localized name for \(variantCode)")
                continue
            }
            XCTAssertEqual(localizedName, expectedName)
        }
    }

    func testLocalizedNameWithoutVariantUsesLanguageCode() {
        let language = WMFLanguage(languageCode: "en", languageVariantCode: nil)

        XCTAssertEqual(language.localizedName, Locale.current.localizedString(forLanguageCode: "en") ?? "en")
    }
}
