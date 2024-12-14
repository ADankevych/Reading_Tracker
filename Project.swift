import ProjectDescription

let project = Project(
    name: "Reading_Tracker",
    targets: [
        .target(
            name: "Reading_Tracker",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Reading-Tracker",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Reading_Tracker/Sources/**"],
            resources: ["Reading_Tracker/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "Reading_TrackerTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Reading-TrackerTests",
            infoPlist: .default,
            sources: ["Reading_Tracker/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Reading_Tracker")]
        ),
    ]
)
