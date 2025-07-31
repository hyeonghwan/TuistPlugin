@preconcurrency import ProjectDescription

let coreModulePathToRoot = "Templates/core"

let coreModule = Template(
    description: "Core Module init Template",
    attributes: [
        .required("name")
    ],
    items: [
        .file(
            path: "Projects/{{ name }}/Project.swift",
            templatePath: "Project.stencil"
        ),
        .file(
            path: "Projects/{{ name }}/Sources/CoreModule.swift",
            templatePath: .relativeToRoot("\(coreModulePathToRoot)/Sources/SceneDelegate.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Tests/{{ name }}Tests.swift",
            templatePath: .relativeToRoot("Templates/feature/Tests/DemoTests.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Config/{{ name }}.xcconfig",
            templatePath: .relativeToRoot("Templates/feature/Config/config.stencil")
        )
    ]
)
