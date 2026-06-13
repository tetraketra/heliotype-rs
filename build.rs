use std::path::PathBuf;

fn main() {
    let config = slint_build::CompilerConfiguration::new().with_library_paths(
        std::collections::HashMap::from([(
            "material".to_string(),
            PathBuf::from(
                &std::env::var_os("CARGO_MANIFEST_DIR").expect("failed to get Cargo manifest dir"),
            )
            .join("ui/material/material.slint"),
        )]),
    );
    slint_build::compile_with_config("ui/main.slint", config).expect("slint build failed.");

    println!("cargo:rerun-if-changed=ui/app.slint");
}
