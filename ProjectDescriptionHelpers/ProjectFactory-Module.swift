@preconcurrency import ProjectDescription

public extension ProjectFactory {
    static func createModule(
        name: String,
        context: ProjectContext,
        product: Product,
        destination: Destinations = [.iPhone],
        resources: ResourceFileElements? = ["Resources/**"],
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = [],
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        coreDataModel: [CoreDataModel] = []
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
                    destinations: destination,
                    product: product,
                    bundleId: "\(context.metadata.appBundleIDPrefix).\(name)Module",
                    deploymentTargets: context.deploymentTarget,
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies,
                    settings: AppConfig.targetConfiguration(name: name, provider: context.pathProvider),
                    coreDataModels: coreDataModel
                ),
                .target(
                    name: "\(name)Tests",
                    destinations: destination,
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
                .makeScheme(config: .dev, name: name),
                .makeScheme(config: .prod, name: name)
            ],
            additionalFiles: [context.pathProvider.sharedGlobPattern()]
        )
    }
}
