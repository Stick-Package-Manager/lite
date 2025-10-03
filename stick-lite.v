module main
import os
import net.http

fn main() {
	args := os.args
	if args.len < 3 {
		println('Usage: stick-lite <install|remove> <pkg>')
		exit(1)
	}
	
	cmd := args[1]
	pkg := args[2]
	
	match cmd {
		'install' {
			println('Installing ${pkg}...')
			if install(pkg) {
				println('${pkg} installed successfully')
			} else {
				eprintln('Failed to install ${pkg}')
				exit(1)
			}
		}
		'remove' {
			println('Removing ${pkg}...')
			if remove(pkg) {
				println('${pkg} removed successfully')
			} else {
				eprintln('Failed to remove ${pkg}')
				exit(1)
			}
		}
		else {
			eprintln('Unknown command: ${cmd}')
			eprintln('Available commands: install, remove')
			exit(1)
		}
	}
}

fn install(pkg string) bool {
	url := 'https://aur.archlinux.org/cgit/aur.git/snapshot/${pkg}.tar.gz'
	
	println('Downloading ${pkg}...')
	resp := http.get(url) or {
		eprintln('Download failed: ${err}')
		return false
	}
	
	if resp.status_code != 200 {
		eprintln('HTTP error: ${resp.status_code}')
		return false
	}
	
	tmp_dir := '/tmp/stick_lite_${pkg}'
	os.rm_all(tmp_dir) or {}
	os.mkdir_all(tmp_dir) or {
		eprintln('Failed to create temp directory')
		return false
	}
	
	archive := '${tmp_dir}/${pkg}.tar.gz'
	os.write_file(archive, resp.body) or {
		eprintln('Failed to save tarball')
		return false
	}
	
	println('Extracting...')
	if os.system('tar -xzf "${archive}" -C "${tmp_dir}"') != 0 {
		eprintln('Failed to extract archive')
		return false
	}
	
	build_dir := '${tmp_dir}/${pkg}'
	pkgbuild := '${build_dir}/PKGBUILD'
	
	if !os.exists(pkgbuild) {
		eprintln('PKGBUILD not found')
		return false
	}
	
	println('Building ${pkg}...')
	build_cmd := 'cd "${build_dir}" && makepkg -si --noconfirm'
	if os.system(build_cmd) != 0 {
		eprintln('Build failed')
		return false
	}
	
	os.rm_all(tmp_dir) or {}
	return true
}

fn remove(pkg string) bool {
	if os.system('sudo pacman -R --noconfirm "${pkg}"') != 0 {
		eprintln('Failed to remove package via pacman')
		return false
	}
	return true
			}
