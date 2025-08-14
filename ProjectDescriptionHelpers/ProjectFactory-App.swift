@preconcurrency import ProjectDescription

public extension ProjectFactory {
    static func createApp(
        name: String,
        context: ProjectContext,
        product: Product = .app,
        platform: Platform = .iOS,
        destination: Destinations = [.iPhone],
        resources: ResourceFileElements? = ["Resources/**"],
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = [],
        packages: [Package] = [],
        infoPlist: InfoPlist = .default
    ) -> Project {
        Project(
            name: name,
            organizationName: AppConfig.orgName,
            options: .options(automaticSchemesOptions: .disabled),
            packages: packages,
            settings: AppConfig.projectConfiguration(context: context),
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .app,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)App",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies,
                    settings: AppConfig.targetConfiguration(name: name, provider: context.pathProvider)
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
                    settings: .settings(base: ["ENABLE_MODULE_VERIFIER": "YES"], configurations: []),
                    additionalFiles: [ context.pathProvider.sharedGlobPattern() ]
                )
            ],
            schemes: [
                .makeScheme(config: .dev, name: name),
                .makeScheme(config: .prod, name: name)
            ]
        )
    }
}
