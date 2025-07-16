
@preconcurrency import ProjectDescription


public extension ProjectFactory {
    static func createModule(
        name: String,
        context: ProjectContext,
        product: Product,
        platform: Platform = .iOS,
        resources: ResourceFileElements? = ["Resources/**"],
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist = .default,
        coreDataModel: [CoreDataModel] = []
    ) -> Project {
        Project(
            name: name,
            organizationName: AppConfig.orgName,
            options: .options(automaticSchemesOptions: .disabled),
            settings: AppConfig.projectConfiguration(context: context),
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
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
                .makeScheme(config: .dev, name: name),
                .makeScheme(config: .prod, name: name)
            ],
            additionalFiles: [context.pathProvider.sharedGlobPattern()]
        )
    }
}
