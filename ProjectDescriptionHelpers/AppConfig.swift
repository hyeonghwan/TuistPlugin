@preconcurrency import ProjectDescription

public enum AppConfig {
    public static let orgName = "com.hwan"
    
    public static func demoAppSceneDeleateSetting(name: String) -> [String: Plist.Value] {
        [
            "UILaunchStoryboardName": "LaunchScreen.storyboard",
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": true,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [
                        [
                            "UISceneConfigurationName": "Default Configuration",
                            "UISceneDelegateClassName": "\(name)Demo.SceneDelegate"
                        ]
                    ]
                ]
            ],
        ]
    }
    
    public static func projectConfiguration(context: ProjectContext) -> Settings {
        .settings(
            configurations:
                [
                    .debug(name: BuildConfig.dev.configName, xcconfig: context.pathProvider.projectConfigPath(for: .dev)),
                    .release(name: BuildConfig.prod.configName, xcconfig: context.pathProvider.projectConfigPath(for: .prod))
                ],
            defaultSettings: .recommended
        )
    }
    
    public static func targetConfiguration(name: String, provider: PathProvider) -> Settings {
        .settings(
            configurations:
                [
                    .debug(name: BuildConfig.dev.configName, xcconfig: provider.xcconfigPath(forName: name)),
                    .release(name: BuildConfig.prod.configName, xcconfig: provider.xcconfigPath(forName: name))
                ],
            defaultSettings: .recommended
        )
    }
    
    public static func demoProjectConfiguration(name: String, provider: PathProvider) -> Settings {
        .settings(
            configurations:
                [
                    .debug(name: BuildConfig.dev.configName, xcconfig: provider.xcconfigPath(forName: name)),
                    .release(name: BuildConfig.prod.configName, xcconfig: provider.xcconfigPath(forName: name))
                ],
            defaultSettings: .recommended
        )
    }
}

/// Project Module 생성 함수 팬텀 enum
public enum ProjectFactory { }

