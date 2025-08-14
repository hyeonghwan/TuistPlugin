@preconcurrency import ProjectDescription

let featurePathToRoot = "Templates/feature"

let app_code = Template(
    description: "UIKit App-code Template",
    attributes: [
        .required("name")
    ],
    items: [
        .file(
            path: "Projects/{{ name }}/Project.swift",
            templatePath: "Project.stencil"
        ),
        .file(
            path: "Projects/{{ name }}/Sources/App/AppDelegate.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Demo/Sources/AppDelegate.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Sources/App/SceneDelegate.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Demo/Sources/SceneDelegate.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Resources/LaunchScreen.storyboard",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Demo/Resources/LaunchScreen.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Tests/{{ name }}Tests.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Tests/DemoTests.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/UITests/{{ name }}UITests.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Tests/DemoTests.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Config/{{ name }}.xcconfig",
            templatePath: .relativeToRoot("Templates/app_code/Config/config.stencil")
        )
    ]
)

