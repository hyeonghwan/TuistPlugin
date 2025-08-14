@preconcurrency import ProjectDescription

public extension ProjectFactory {
    static func createModuleWithDemo(
        name: String,
        context: ProjectContext,
        product: Product,
        destination: Destinations = [.iPhone],
        resources: ResourceFileElements? = ["Resources/**"],
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = [],
        packages: [Package] = [],
        infoPlist: InfoPlist = .default
    ) -> Project {
        Project(
            name: name,
            organizationName: context.metadata.orgName,
            options: .options(automaticSchemesOptions: .disabled),
            packages: packages,
            settings: AppConfig.projectConfiguration(context: context),
            targets: [
                .target(
                    name: name,
                    destinations: destination,
                    product: product,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies,
                    settings: AppConfig.targetConfiguration(name: name, provider: context.pathProvider)
                ),
                
                .target(
                    name: "\(name)Demo",
                    destinations: destination,
                    product: .app,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)Demo",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: .extendingDefault(with: AppConfig.demoAppSceneDeleateSetting(name: name)),
                    sources: ["\(name)Demo/**"],
                    resources: ["\(name)Demo/Resources/**"],
                    dependencies: [
                        .target(name: name)
                    ],
                    settings: AppConfig.demoProjectConfiguration(name: name, provider: context.pathProvider)
                ),
                .target(
                    name: "\(name)DemoTests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)DemoTests",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: .default,
                    sources: ["\(name)Demo/Tests/**"],
                    dependencies: [
                        .target(name: "\(name)Demo")
                    ]
                ),
                .target(
                    name: "\(name)DemoUITests",
                    destinations: .iOS,
                    product: .uiTests,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)DemoUITests",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: .default,
                    sources: ["\(name)Demo/UITests/**"],
                    dependencies: [
                        .target(name: "\(name)Demo")
                    ]
                ),
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)Tests",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [
                        .target(name: name)
                    ],
                    settings: .settings(base: ["ENABLE_MODULE_VERIFIER": "YES"], configurations: [])
                )
            ],
            schemes: [
                .makeDemoScheme(name: name),
                .makeScheme(config: .dev, name: name),
                .makeScheme(config: .prod, name: name)
            ],
            additionalFiles: [context.pathProvider.sharedGlobPattern()]
        )
    }
}
