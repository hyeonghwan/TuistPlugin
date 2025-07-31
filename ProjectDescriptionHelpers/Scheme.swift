@preconcurrency import ProjectDescription

// MARK: - Scheme 생성 확장
extension Scheme {
    static func makeScheme(config: BuildConfig, name: String) -> Scheme {
        return Scheme.scheme(
            name: "\(name)-\(config.rawValue)",
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: config.configName,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: config.configName),
            archiveAction: .archiveAction(configuration: config.configName),
            profileAction: .profileAction(configuration: config.configName),
            analyzeAction: .analyzeAction(configuration: config.configName)
        )
    }
    
    static func makeDemoScheme(config: BuildConfig = .dev, name: String) -> Scheme {
        Scheme.scheme(
            name: "\(name)Demo-\(config.rawValue)",
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                [
                    "\(name)DemoTests",
                    "\(name)DemoUITests"
                ],
                configuration: config.configName,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: config.configName),
            archiveAction: .archiveAction(configuration: config.configName),
            profileAction: .profileAction(configuration: config.configName),
            analyzeAction: .analyzeAction(configuration: config.configName)
        )
    }
}

