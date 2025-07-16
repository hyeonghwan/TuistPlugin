@preconcurrency import ProjectDescription

let app = Template(
    description: "UIKit App Template",
    attributes: [
        .required("name")
    ],
    items: [
        .file(
            path: "Projects/{{ name }}/Project.swift",
            templatePath: "feature/Project.stencil"
        ),

        .file(
            path: "Projects/{{ name }}/Sources/AppDelegate.swift",
            templatePath: "feature/Sources/AppDelegate.stencil"
        ),
        .file(
            path: "Projects/{{ name }}/Sources/SceneDelegate.swift",
            templatePath: "feature/Sources/SceneDelegate.stencil"
        ),

        .file(
            path: "Projects/{{ name }}/Resources/LaunchScreen.storyboard",
            templatePath: "features/Resources/LaunchScreen.stencil"
        ),

        .file(
            path: "Projects/{{ name }}/Tests/{{ name }}Tests.swift",
            templatePath: "feature/Tests/Tests.stencil"
        ),
        .file(
            path: "Projects/{{ name }}/UITests/{{ name }}UITests.swift",
            templatePath: "feature/Tests/Tests.stencil"
        ),

        .file(
            path: "Projects/{{ name }}/Config/{{ name }}.xcconfig",
            templatePath: "feature/Config/config.stencil"
        )
    ]
)
