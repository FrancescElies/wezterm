# toolkit.nu — helpers for building wezterm packages

# Build release binaries and produce a .deb via ci/deploy.sh
export def create-deb [
    --install
    target_dir: string = "target"
] {
    print $"(ansi pi)cargo build --release(ansi reset)"
    cargo build --release
    print $"(ansi pi)ci/deploy.sh (ansi reset)"
    bash ci/deploy.sh $target_dir
    if $install {
        print $"(ansi pi)install .deb (ansi reset)"
        sudo dpkg -i ./*.deb
        sudo apt-get install -f -y  # fix missing deps
  }
}
