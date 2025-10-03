module main
import os
import net.http
import json
fn main(){
	if os.args.len<3{println('Usage: stick-lite <install|remove> <pkg>');return}
	cmd:=os.args[1]
	pkg:=os.args[2]
	match cmd{
		'install'{install(pkg)}
		'remove'{remove(pkg)}
		else{println('Unknown cmd')}
	}
}
fn install(p string){
	u:='https://aur.archlinux.org/cgit/aur.git/snapshot/${p}.tar.gz'
	r:=http.get(u)or{eprintln('Download failed');return}
	if r.status_code!=200{eprintln('HTTP ${r.status_code}');return}
	t:='/tmp/${p}'
	os.mkdir_all(t)or{return}
	a:='${t}/${p}.tar.gz'
	os.write_file(a,r.body)or{return}
	os.system('tar -xzf "${a}" -C "${t}"')
	b:='${t}/${p}'
	if !os.exists('${b}/PKGBUILD'){eprintln('No PKGBUILD');return}
	os.system('sh -c "cd \\"${b}\\" && makepkg -si --noconfirm"')
	println('${p} installed')
}
fn remove(p string){
	os.system('sudo pacman -R --noconfirm ${p}')
	println('${p} removed')
}
