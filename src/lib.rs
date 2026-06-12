// VSCODE: { "rust-analyzer.cargo.target": "aarch64-linux-android" }
// #[cfg(target_os = "android")]
#[unsafe(no_mangle)]
fn android_main(app: slint::android::AndroidApp) {
    slint::android::init(app).unwrap();

    slint::slint! {
        export component MainWindow inherits Window {
            Text { text: "Hello world!"; }
        }
    }

    MainWindow::new().unwrap().run().unwrap();
}
