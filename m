Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVL1CW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVL1CW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVL1CW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:22:26 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:13718 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S932446AbVL1CWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:22:25 -0500
Date: Tue, 27 Dec 2005 21:22:21 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
In-Reply-To: <Pine.LNX.4.60.0512280229530.30594@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.64.0512272121230.11181@innerfire.net>
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
 <200512270149.24440.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
 <200512271545.31224.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
 <Pine.LNX.4.60.0512280103100.29982@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.64.0512271927130.5956@innerfire.net>
 <Pine.LNX.4.60.0512280229530.30594@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658635175-52607517-1135736541=:11181"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658635175-52607517-1135736541=:11181
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE


/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel=
-module
ATI module generator V 2.0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
initializing...
cleaning...
patching 'highmem.h'...
assuming new VMA API since we do have kernel 2.6.x...
doing Makefile based build for kernel 2.6.x and higher
make -C /lib/modules/2.6.15-rc7/build SUBDIRS=3D/usr/local/src/fglrx64-asse=
mble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x modules
make[1]: Entering directory `/usr/src/linux-2.6.15-rc7'
mkdir -p /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel=
-module/build_mod/2.6.x/.tmp_versions
make -f scripts/Makefile.build obj=3D/usr/local/src/fglrx64-assemble_script=
s/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x
  Building modules, stage 2.
make -rR -f /usr/src/linux-2.6.15-rc7/scripts/Makefile.modpost
  scripts/mod/modpost -m -a -i /usr/src/linux-2.6.15-rc7/Module.symvers vml=
inux /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-mod=
ule/build_mod/2.6.x/fglrx.o
Warning: could not find /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.=
8-x86_64-kernel-module/build_mod/2.6.x/.libfglrx_ip.a.GCC4.cmd for /usr/loc=
al/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod=
/2.6.x/libfglrx_ip.a.GCC4
make[1]: Leaving directory `/usr/src/linux-2.6.15-rc7'
build succeeded with return value 0
 compiling fglrx_agp.ko module
make -C /lib/modules/2.6.15-rc7/build SUBDIRS=3D/usr/local/src/fglrx64-asse=
mble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart mod=
ules
make[1]: Entering directory `/usr/src/linux-2.6.15-rc7'
mkdir -p /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel=
-module/build_mod/firegl_agpgart/.tmp_versions
make -f scripts/Makefile.build obj=3D/usr/local/src/fglrx64-assemble_script=
s/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart
  gcc -Wp,-MD,/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-k=
ernel-module/build_mod/firegl_agpgart/.firegl_wrap.o.d  -nostdinc -isystem =
/usr/lib/gcc/x86_64-linux-gnu/4.0.3/include -D__KERNEL__ -Iinclude  -includ=
e include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs=
 -fno-strict-aliasing -fno-common -ffreestanding -Os     -fomit-frame-point=
er -march=3Dk8 -mno-red-zone -mcmodel=3Dkernel -pipe -fno-reorder-blocks=09=
 -Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-ss=
e -mno-mmx -mno-sse2 -mno-3dnow -Wdeclaration-after-statement -Wno-pointer-=
sign -I/usr/src/linux-2.6.15-rc7 -D__AGP__ -DFGL -DFGL_LINUX -DFGL_GART_RES=
ERVED_SLOT -DFGL_LINUX253P1_VMA_API -DPAGE_ATTR_FIX=3D1   -DMODULE -DATI_AG=
P_HOOK -DATI -DFGL -DFGL_RX -DFGL_CUSTOM_MODULE -DPAGE_ATTR_FIX=3D1  -DMODV=
ERSIONS -DKBUILD_BASENAME=3Dfiregl_wrap -DKBUILD_MODNAME=3Dfglrx_agp -c -o =
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/.tmp_firegl_wrap.o /usr/local/src/fglrx64-assemble_=
scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_w=
rap.c
In file included from /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-=
x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:113:
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_agp.h:755:1: warning: "PCI_DEVICE_ID_INTEL_I=
CH7_1" redefined
In file included from include/linux/pci.h:26,
                 from /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-=
x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:74:
include/linux/pci_ids.h:2051:1: warning: this is the location of the previo=
us definition
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:121:25: error: asm/ioctl32.h: No such=
 file or directory
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:171: error: static declaration of 'er=
rno' follows non-static declaration
include/linux/unistd.h:4: error: previous declaration of 'errno' was here
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_phys_to_virt':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:660: warning: passing argument 1 of '=
phys_to_virt' makes integer from pointer without a cast
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:660: warning: return makes integer fr=
om pointer without a cast
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: At top level:
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:695: error: conflicting types for '__=
ke_pci_find_class'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.h:419: error: previous declaration of '=
__ke_pci_find_class' was here
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_pci_find_class':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:697: warning: implicit declaration of=
 function 'pci_find_class'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:697: error: incompatible types in ret=
urn
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function 'firegl_get_user_ptr':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:762: warning: assignment makes pointe=
r from integer without a cast
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function 'firegl_put_user_ptr':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to in=
teger of different size
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to in=
teger of different size
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to in=
teger of different size
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to in=
teger of different size
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_verify_area':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:1123: warning: implicit declaration o=
f function 'verify_area'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_get_vm_phys_addr':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:1362: error: 'struct <anonymous>' has=
 no member named 'pud'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_register_ioctl32_c=
onversion':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:1689: warning: implicit declaration o=
f function 'register_ioctl32_conversion'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_unregister_ioctl32=
_conversion':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:1694: warning: implicit declaration o=
f function 'unregister_ioctl32_conversion'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_vm_phys_addr_str':
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:1818: error: 'struct <anonymous>' has=
 no member named 'pud'
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_smp_call_function'=
:
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/b=
uild_mod/firegl_agpgart/firegl_wrap.c:2252: warning: statement with no effe=
ct
make[2]: *** [/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-k=
ernel-module/build_mod/firegl_agpgart/firegl_wrap.o] Error 1
make[1]: *** [_module_/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-=
x86_64-kernel-module/build_mod/firegl_agpgart] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.15-rc7'
make: *** [default] Error 2
AGPGART module build failed with return value 2
duplication skipped - generator was not called from regular lib tree
done.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module
--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
--658635175-52607517-1135736541=:11181--
