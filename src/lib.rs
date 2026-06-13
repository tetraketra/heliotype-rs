use slint::android::{self, AndroidApp};

slint::include_modules!();

#[unsafe(no_mangle)]
fn android_main(app: AndroidApp) {
    android::init(app).expect("slint android init failed");

    let ui = App::new().expect("ui init failed");

    ui.run().expect("ui runtime failed");
}
