Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSF2Xf0>; Sat, 29 Jun 2002 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSF2XfZ>; Sat, 29 Jun 2002 19:35:25 -0400
Received: from dialin-145-254-148-162.arcor-ip.net ([145.254.148.162]:19438
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S313867AbSF2XfW>; Sat, 29 Jun 2002 19:35:22 -0400
Date: Sun, 30 Jun 2002 00:59:03 +0200
From: Nico Schottelius <nicos-mutt@pcsystems.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel compile problems: 2.5.24
Message-ID: <20020629225902.GA1109@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello!

I just attached the output of bzImage, I've never seens this
error before.

Do you know if that's a kernel problem or one of my system ?

Btw, several modules like LVM, Raid and Aironet driver make the
make process fail!

Greetings,

Nico

p.s.: please cc me, I am not subscribed.

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=KERN_LD_ERR

make[1]: Entering directory `/usr/src/linux-2.5.24/scripts'
make[1]: Leaving directory `/usr/src/linux-2.5.24/scripts'
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make[1]: Entering directory `/usr/src/linux-2.5.24/init'
  Generating /usr/src/linux-2.5.24/include/linux/compile.h (unchanged)
make[1]: Leaving directory `/usr/src/linux-2.5.24/init'
make[1]: Entering directory `/usr/src/linux-2.5.24/kernel'
make[1]: Leaving directory `/usr/src/linux-2.5.24/kernel'
make[1]: Entering directory `/usr/src/linux-2.5.24/mm'
make[1]: Leaving directory `/usr/src/linux-2.5.24/mm'
make[1]: Entering directory `/usr/src/linux-2.5.24/fs'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/autofs4'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/autofs4'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/devpts'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/devpts'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/driverfs'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/driverfs'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/exportfs'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/exportfs'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/ext2'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/ext2'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/isofs'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/isofs'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/lockd'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/lockd'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/nfs'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/nfs'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/nfsd'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/nfsd'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/partitions'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/partitions'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/proc'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/proc'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/ramfs'
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/ramfs'
make[1]: Leaving directory `/usr/src/linux-2.5.24/fs'
make[1]: Entering directory `/usr/src/linux-2.5.24/ipc'
make[1]: Leaving directory `/usr/src/linux-2.5.24/ipc'
make[1]: Entering directory `/usr/src/linux-2.5.24/lib'
make[1]: Leaving directory `/usr/src/linux-2.5.24/lib'
make[1]: Entering directory `/usr/src/linux-2.5.24/drivers'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/base'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/base'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/block'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/block'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/cdrom'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/cdrom'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/char'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/char/agp'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/char/agp'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/char/drm'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/char/drm'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/char/pcmcia'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/char/pcmcia'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/char'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/ide'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/ide'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/media'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/media/radio'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/media/radio'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/media/video'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/media/video'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/media'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/misc'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/misc'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/net'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/net/e100'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/net/e100'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/net/pcmcia'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/net/pcmcia'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/net'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/parport'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/parport'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/pci'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/pci'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/pcmcia'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/pcmcia'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/pnp'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/pnp'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/scsi'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/scsi/pcmcia'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/scsi/pcmcia'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/scsi'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/usb'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/usb/core'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/usb/core'
make[3]: Entering directory `/usr/src/linux-2.5.24/drivers/usb/storage'
make[3]: Leaving directory `/usr/src/linux-2.5.24/drivers/usb/storage'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/usb'
make[2]: Entering directory `/usr/src/linux-2.5.24/drivers/video'
make[2]: Leaving directory `/usr/src/linux-2.5.24/drivers/video'
make[1]: Leaving directory `/usr/src/linux-2.5.24/drivers'
make[1]: Entering directory `/usr/src/linux-2.5.24/sound'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/arm'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/arm'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/core'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/core/oss'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/core/oss'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/core/seq'
make[4]: Entering directory `/usr/src/linux-2.5.24/sound/core/seq/instr'
make[4]: Leaving directory `/usr/src/linux-2.5.24/sound/core/seq/instr'
make[4]: Entering directory `/usr/src/linux-2.5.24/sound/core/seq/oss'
make[4]: Leaving directory `/usr/src/linux-2.5.24/sound/core/seq/oss'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/core/seq'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/core'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/drivers'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/drivers/mpu401'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/drivers/mpu401'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/drivers/opl3'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/drivers/opl3'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/drivers'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/i2c'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/i2c'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/isa'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/ad1816a'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/ad1816a'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/ad1848'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/ad1848'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/cs423x'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/cs423x'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/es1688'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/es1688'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/gus'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/gus'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/opti9xx'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/opti9xx'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/sb'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/sb'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/isa/wavefront'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/isa/wavefront'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/isa'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/pci'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/ac97'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/ac97'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/ali5451'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/ali5451'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/cs46xx'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/cs46xx'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/emu10k1'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/emu10k1'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/korg1212'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/korg1212'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/nm256'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/nm256'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/rme9652'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/rme9652'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/trident'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/trident'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/pci/ymfpci'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/pci/ymfpci'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/pci'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/ppc'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/ppc'
make[2]: Entering directory `/usr/src/linux-2.5.24/sound/synth'
make[3]: Entering directory `/usr/src/linux-2.5.24/sound/synth/emux'
make[3]: Leaving directory `/usr/src/linux-2.5.24/sound/synth/emux'
make[2]: Leaving directory `/usr/src/linux-2.5.24/sound/synth'
make[1]: Leaving directory `/usr/src/linux-2.5.24/sound'
make[1]: Entering directory `/usr/src/linux-2.5.24/net'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/802'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/802'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/core'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/core'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/ethernet'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/ethernet'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/ipv4'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/ipv4'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/netlink'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/netlink'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/packet'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/packet'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/sched'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/sched'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/sunrpc'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/sunrpc'
make[2]: Entering directory `/usr/src/linux-2.5.24/net/unix'
make[2]: Leaving directory `/usr/src/linux-2.5.24/net/unix'
make[1]: Leaving directory `/usr/src/linux-2.5.24/net'
make[1]: Entering directory `/usr/src/linux-2.5.24/arch/i386/kernel'
make[2]: Entering directory `/usr/src/linux-2.5.24/arch/i386/kernel/cpu'
make[2]: Leaving directory `/usr/src/linux-2.5.24/arch/i386/kernel/cpu'
make[1]: Leaving directory `/usr/src/linux-2.5.24/arch/i386/kernel'
make[1]: Entering directory `/usr/src/linux-2.5.24/arch/i386/mm'
make[1]: Leaving directory `/usr/src/linux-2.5.24/arch/i386/mm'
make[1]: Entering directory `/usr/src/linux-2.5.24/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.5.24/arch/i386/lib'
make[1]: Entering directory `/usr/src/linux-2.5.24/arch/i386/pci'
make[1]: Leaving directory `/usr/src/linux-2.5.24/arch/i386/pci'
  Generating build number
make[1]: Entering directory `/usr/src/linux-2.5.24/init'
  Generating /usr/src/linux-2.5.24/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.24/init'
  ld -m elf_i386 -T /usr/src/linux-2.5.24/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /usr/src/linux-2.5.24/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.24/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `vt_ioctl':
drivers/built-in.o(.text+0x11833): undefined reference to `key_maps'
drivers/built-in.o(.text+0x118e6): undefined reference to `key_maps'
drivers/built-in.o(.text+0x11902): undefined reference to `key_maps'
drivers/built-in.o(.text+0x1191d): undefined reference to `keymap_count'
drivers/built-in.o(.text+0x1197b): undefined reference to `key_maps'
drivers/built-in.o(.text+0x11985): undefined reference to `keymap_count'
drivers/built-in.o(.text+0x119d7): undefined reference to `key_maps'
drivers/built-in.o(.text+0x119f6): undefined reference to `keymap_count'
drivers/built-in.o(.text+0x11b06): undefined reference to `func_table'
drivers/built-in.o(.text+0x11bcc): undefined reference to `func_table'
drivers/built-in.o(.text+0x11bd2): undefined reference to `funcbufsize'
drivers/built-in.o(.text+0x11bd8): undefined reference to `funcbufleft'
drivers/built-in.o(.text+0x11bde): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11c15): undefined reference to `func_table'
drivers/built-in.o(.text+0x11c35): undefined reference to `func_table'
drivers/built-in.o(.text+0x11c48): undefined reference to `func_table'
drivers/built-in.o(.text+0x11cd2): undefined reference to `func_table'
drivers/built-in.o(.text+0x11ce0): undefined reference to `func_table'
drivers/built-in.o(.text+0x11cfa): more undefined references to `func_table' follow
drivers/built-in.o: In function `vt_ioctl':
drivers/built-in.o(.text+0x11d04): undefined reference to `funcbufleft'
drivers/built-in.o(.text+0x11d62): undefined reference to `func_table'
drivers/built-in.o(.text+0x11d68): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11d9c): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11daa): undefined reference to `func_table'
drivers/built-in.o(.text+0x11dba): undefined reference to `func_table'
drivers/built-in.o(.text+0x11dd6): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11e06): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11e16): undefined reference to `func_table'
drivers/built-in.o(.text+0x11e2a): undefined reference to `func_table'
drivers/built-in.o(.text+0x11e3b): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11e40): undefined reference to `func_buf'
drivers/built-in.o(.text+0x11e54): undefined reference to `funcbufleft'
drivers/built-in.o(.text+0x11e5e): undefined reference to `funcbufptr'
drivers/built-in.o(.text+0x11e6c): undefined reference to `funcbufsize'
drivers/built-in.o(.text+0x11e71): undefined reference to `funcbufleft'
drivers/built-in.o(.text+0x11e77): undefined reference to `funcbufsize'
drivers/built-in.o(.text+0x11e81): undefined reference to `func_table'
drivers/built-in.o(.text+0x11ebd): undefined reference to `accent_table_size'
drivers/built-in.o(.text+0x11ed5): undefined reference to `accent_table_size'
drivers/built-in.o(.text+0x11ede): undefined reference to `accent_table'
drivers/built-in.o(.text+0x11f31): undefined reference to `accent_table_size'
drivers/built-in.o(.text+0x11f45): undefined reference to `accent_table'
drivers/built-in.o: In function `handle_scancode':
drivers/built-in.o(.text+0x1e9e3): undefined reference to `key_maps'
drivers/built-in.o(.text+0x1ea31): undefined reference to `key_maps'
drivers/built-in.o: In function `handle_diacr':
drivers/built-in.o(.text+0x1eee8): undefined reference to `accent_table_size'
drivers/built-in.o(.text+0x1ef03): undefined reference to `accent_table'
drivers/built-in.o(.text+0x1ef53): undefined reference to `accent_table'
drivers/built-in.o: In function `do_fn':
drivers/built-in.o(.text+0x1ef89): undefined reference to `func_table'
drivers/built-in.o: In function `compute_shiftstate':
drivers/built-in.o(.text+0x1f209): undefined reference to `plain_map'
drivers/built-in.o: In function `do_slock':
drivers/built-in.o(.text+0x1f34d): undefined reference to `key_maps'
make: *** [vmlinux] Error 1

--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Hju2tnlUggLJsX0RArgeAJ9Sg8nrRxEMTvpVI10KqMJUOZ3EZQCgi9qi
3C9za4RPkO9PKTQfoPeSXtY=
=1nKw
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
