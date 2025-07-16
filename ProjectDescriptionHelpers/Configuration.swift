@preconcurrency import ProjectDescription

public enum BuildConfig: String {
    case dev = "DEV"
    case prod = "PROD"
    public var configName: ConfigurationName {
        return ConfigurationName.configuration(self.rawValue)
    }
}

public struct ProjectContext {
    public let metadata: ProjectMetadata
    public let pathProvider: PathProvider
    public let deploymentTarget: DeploymentTargets
    public let defaultSettings: SettingsDictionary
    
    public init(metadata: ProjectMetadata, pathProvider: PathProvider, deploymentTarget: DeploymentTargets, defaultSettings: SettingsDictionary) {
        self.metadata = metadata
        self.pathProvider = pathProvider
        self.deploymentTarget = deploymentTarget
        self.defaultSettings = defaultSettings
    }
}

public struct ProjectMetadata {
    public let orgName: String
    public let appBundleIDPrefix: String
    
    public init(orgName: String, appBundleIDPrefix: String) {
        self.orgName = orgName
        self.appBundleIDPrefix = appBundleIDPrefix
    }
}

public struct PathProvider {
    public let configDirectory: String
    
    public init(configDirectory: String) {
        self.configDirectory = configDirectory
    }
    
    public func xcconfigPath(for config: BuildConfig) -> Path {
        .relativeToRoot("\(configDirectory)/\(config.rawValue.lowercased()).xcconfig")
    }
    
    public func xcconfigPath(forName name: String) -> Path {
        .relativeToRoot("\(configDirectory)/\(name).xcconfig")
    }
    
    public func sharedGlobPattern() -> FileElement {
        .glob(pattern: .relativeToRoot("\(configDirectory)/shared.xcconfig"))
    }
}

extension Configuration {
    public static func build(_ type: BuildConfig, pathProvider: PathProvider) -> Self {
        switch type {
        case .dev:
            return .debug(
                name: BuildConfig.dev.configName,
                xcconfig: pathProvider.xcconfigPath(for: .dev)
            )
        case .prod:
            return .release(
                name: BuildConfig.prod.configName,
                xcconfig: pathProvider.xcconfigPath(for: .prod)
            )
        }
    }
}
