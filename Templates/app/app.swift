@preconcurrency import ProjectDescription

let featurePathToRoot = "Templates/feature"

let app = Template(
    description: "UIKit App Template",
    attributes: [
        .required("name")
    ],
    items: [
        .file(
            path: "Projects/{{ name }}/Project.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Project.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Sources/AppDelegate.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Demo/Sources/AppDelegate.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Sources/SceneDelegate.swift",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Demo/Sources/SceneDelegate.stencil")
        ),
        .file(
            path: "Projects/{{ name }}/Resources/Main.storyboard",
            templatePath: .relativeToRoot("\(featurePathToRoot)/Demo/Resources/Main.stencil")
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
            templatePath: .relativeToRoot("\(featurePathToRoot)/Config/config.stencil")
        )
    ]
)
