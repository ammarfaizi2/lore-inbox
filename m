Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVCUUsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVCUUsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVCUUsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:48:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:20629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261866AbVCUUmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:42:39 -0500
Date: Mon, 21 Mar 2005 12:41:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm1
Message-Id: <20050321124159.0fbf1bef.akpm@osdl.org>
In-Reply-To: <20050321202022.B16069@flint.arm.linux.org.uk>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	<20050321202022.B16069@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Mon, Mar 21, 2005 at 02:51:59AM -0800, Andrew Morton wrote:
>  > - Linus is away this week.  Not a lot more should be going into 2.6.12 now
>  >   and I have a list of ~140 bugs, many of which are post-2.6.10 regressions. 
>  >   We should fix these.
> 
>  Is this your own personal bug list, or is it accessible anywhere?

It's just an email folder at present.  A totally unscreened summary is
below.  USB, ALSA, Input, ACPI and suspend are the usual culprits.


From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [BUG] 2.4.27 - 2.4.29 tar: /dev/nst0: Warning: Cannot seek: Illegal seekg

From: Sebastian =?iso-8859-1?q?K=FCgler?= <lists@vizZzion.org>
Subject: PCMCIA breaks suspend-to-(disk|ram) with 2.6.11

From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject:  2.6.11: iostat values broken ?

From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Subject: 2.6.11: suspending laptop makes system randomly unstable

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4281] New: ALPS Touchpad Tap-to-Click Broken

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4282] New: ALSA driver in Linux 2.6.11 causes a

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4283] New: weird messages after normal kernel

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4281] New: ALPS Touchpad Tap-to-Click Broken

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4282] New: ALSA driver in Linux 2.6.11 causes a

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4283] New: weird messages after normal kernel

From: Grzegorz Kulewski <kangur@polcom.net>
Subject: 2.6.11 (stable and -rc) ACPI breaks USB

From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: intel 8x0 went silent in 2.6.11

From: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
Subject: Re: mouse still losing sync and thus jumping around

From: "George Georgalis" <george@galis.org>
Subject: problem with linux 2.6.11 and sa

Subject: Keyboard doesn't work with CONFIG_PNP in 2.6.11-rc5-mm1
From: Alexander Nyberg <alexn@dsv.su.se>

From: Marko Rebrina <mrebrina@gmail.com>
Subject: Problem with w6692 & kernel >=2.6.10

From: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
Subject: v.2.6.11 mouse still losing sync and thus jumping around

From: Richard Fuchs <richard.fuchs@inode.info>
Subject: slab corruption in skb allocs

From: bugme-daemon@osdl.org
Subject: [Bug 4287] New: bttv not working bt878 

From: bugme-daemon@osdl.org
Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4288] New: Power button stops working after resumt

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4289] New: admtek comet does not work anymore!

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4290] New: pktcdvd packet-writing device suffers

From: Andy Isaacson <adi@hexapodia.org>
Subject: 2.6.11-rc4: Alps touchpad too slow

From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4291] New: usb harddisk don' work,

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4293] New: mandatory locking fails on tmpfs

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4295] New: Garbage all over the screen when using

From: Richard Fuchs <richard.fuchs@inode.info>
Subject: Re: slab corruption in skb allocs

Subject: [PATCH] [VIA RHINE] older chips oops on shutdown
From: olof@austin.ibm.com (Olof Johansson)

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4297] New: VIA 82xxx sound problem with kernel

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4298] New: swsusp fails to suspend if

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4299] New: glidepoint touchpad movement broken

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4300] New: hpt366 S-ATA driver causes the kernel

Subject: amd64 2.6.11 oops on modprobe
From: Andrei Mikhailovsky <andrei@arhont.com>

From: John covici <covici@ccs.covici.com>
Subject: X not working with Radeon 9200 under 2.6.11

Subject: Re: 2.6.11 breaks ALSA Intel AC97 audio
From: Lee Revell <rlrevell@joe-job.com>

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [2.6.11 Permedia-2 Framebuffer] driver broken (?).

From: Lobiuc Andrei <alobiuc@yahoo.com>
Subject: PROBLEM: Radeon card displays incorrectly under the 2.6.11 version unless compiled with SMP support

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4306] New: USB no longer survives resume in 2.6.11

Subject: Panic in ext3 reservation code on 2.6.11-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4311] New: ACPI resume from S3 disables interrupt

Subject: Re: 2.6.11-mm1
From: Alexander Nyberg <alexn@dsv.su.se>

Subject: aio stress panic on 2.6.11-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>

From: Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Fusion-MPT much faster as module

From: Jochen Suckfuell <jo-lkml@suckfuell.net>
Subject: 2.6.11 bug: unbacked private shared memory segments missing in core dump

From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Adaptec 29160 + Promise Ultratrak100 TX8 problems

From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.11-mm2 vs audio for kino and tvtime

From: Michal Vanco <vanco@satro.sk>
Subject: 2.6.11 on AMD64 traps

Subject: Re: [Oops] 2.6.10: PREEMPT SMP
From: Andrew Taylor <taylor@array.ca>

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4315] New: DMA timeouts on ASUS M2400N

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4320] New: S4 reboots machine when AC is connected

From: Jean Delvare <khali@linux-fr.org>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime

From: Stefano Rivoir <s.rivoir@gts.it>
Subject: Re: 2.6.11-mm2

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4323] New: no cursor in console with intelfb

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4322] New: writev systemcall execution fails

From: Jon Smirl <jonsmirl@gmail.com>
Subject: current linus bk, error mounting root

From: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
Subject: Log full of "ing_filter:  fixed  ippp2 out ippp2"

From: Christian Henz <christian.henz@gmail.com>
Subject: 2.6.11-mm2 + Radeon crash

From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
Subject: [BUG] 2.6.11- sym53c8xx Broken on pp64

From: "Florian Leuthner" <florian_leuthner@hotmail.com>
Subject: toshiba ACPI /proc interface nonresponsive (>2.6.9)

From: Chuck Lever <cel@citi.umich.edu>
Subject: 2.6.11 oops in skb_drop_fraglist

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4326] New: System call returns EFAULT instead of

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: fix-u32-vs-pm_message_t-in-usb

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4329] New: USB-HDD were not recognized

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4330] New: sn9c102: no overlay support

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4331] New: ADM1026  lands in Div by 0 fault

From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: i830 DRM problems

From: "deng_ya_nuo@21cn.com" <deng_ya_nuo@21cn.com>
Subject: BUG still exist : __iounmap Error in 2.6.11.2.

From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Re: Re: BUG still exist : __iounmap Error in 2.6.11.2.

From: "deng_ya_nuo@21cn.com" <deng_ya_nuo@21cn.com>
Subject: Re: Re: BUG still exist : __iounmap Error in 2.6.11.2.

From: Felix von Leitner <felix-linuxkernel@fefe.de>
Subject: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10

Subject: Re: [PATCH] Support for GEODE CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4318] New: fcntly system calls with options

From: Sean Neakums <sneakums@zork.net>
Subject: DRI breakage, 2.6.11-mm[123]

From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: current linus bk, error mounting root

Subject: OSS Audio borked between 2.6.6 and 2.6.10
From: Greg Stark <gsstark@mit.edu>

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4333] New: HPFS support is broken on amd64 platform

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4334] New: kernel support for netmos 9835/9735

Subject: Re: [PATCH] Support for GEODE CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>

From: Felix von Leitner <felix-linuxkernel@fefe.de>
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10

From: Miles Lane <miles.lane@gmail.com>
Subject: Oops: 2.6.11-mm3 -- NULL pointer -- EIP is at i2c_add_driver+0xa2/0xd0

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4337] New: ATI Rage 128: messed up X

From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.11-mm3 - DRM/i915 broken

From: Miles Lane <miles.lane@gmail.com>
Subject: Who should I write to about this OOPS in 2,6,11-mm3?

From: Eric Dumazet <dada1@cosmosbay.com>
Subject: [BUG?] x86_64 : Can not read /dev/kmem ?

From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: mouse&keyboard with 2.6.10+

From: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: 2.6.11-mm3: SIS5513 DMA problem (set_drive_speed_status)

From: Vojtech Pavlik <vojtech@suse.cz>
Subject: PowerNow-K8 and Winchester CPUs

From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: SVGATextMode on 2.6.11

From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: SVGATextMode on 2.6.11

From: "Enrico Bartky" <DOSProfi@web.de>
Subject: SMbus not enabled

From: Stefano Rivoir <s.rivoir@gts.it>
Subject: Re: 2.6.11-mm3

Subject: Problem with 2.6.11-bk[3456]
From: Andrew Clayton <andrew@digital-domain.net>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.11-mm3 mouse oddity

From: Russell Coker <russell@coker.com.au>
Subject: idr_remove

From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: Re: 2.6.10 devfs oops without devfs mounted at all

From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: Fw: NFS (ext3/VFS?) bug in 2.6.8/10

Subject: Re: Fw: NFS (ext3/VFS?) bug in 2.6.8/10
From: Trond Myklebust <trond.myklebust@fys.uio.no>

From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: Fw: NFS (ext3/VFS?) bug in 2.6.8/10

From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Who should I write to about this OOPS in 2,6,11-mm3?

From: Michal Zalewski <lcamtuf@dione.ids.pl>
Subject: [Security] ISO9660 fs problems - no maintainer?

From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Subject: 2.6.11 USB broken on VIA computer (not just ACPI)

Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Bjorn Helgaas <bjorn.helgaas@hp.com>

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Who should I write to about this OOPS in 2,6,11-mm3?

From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Who should I write to about this OOPS in 2,6,11-mm3?

Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Bjorn Helgaas <bjorn.helgaas@hp.com>

From: bugme-daemon@osdl.org
Subject: [Bug 4275] filesystems no longer modifiable after stress tests

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4344] New: CIFS Oops on 'ls'

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4340] New: ohci_1394 module breaks S3 suspend

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4341] New: Accessing Palm over USB in drive mode

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4342] New: "Near touchpad upper buttons" not

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4347] New: savavgfb ddc eeprom oops when "sensors"

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4348] New: snd_emu10k1 oops'es with Audigy 2 and

From: Ralf Baechle <ralf@linux-mips.org>
Subject: Double free of initramfs

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4352] New: Problems with PowerNow on Athlon-XP

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4356] New: No sound with outbound calls from

From: bugme-daemon@osdl.org
Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4358] New: bluetooth-dongle (hci_usb) doesn't work

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4359] New: With HT off in bios,

From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Who should I write to about this OOPS in 2,6,11-mm3?

Subject: AIO panic on 2.6.11 on PPC64 caused by is_hugepage_only_range()
From: Daniel McNeil <daniel@osdl.org>

From: dave <dave.m@email.it>
Subject: PROBLEM: 2.6.11.4 vaio z1xmp mouse click

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4363] New: panic spin_lock already locked

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4362] New: No keyboard at all

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4365] New: On Running File System stress on XFS

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4368] New: b44 driver + udev: does not work if

From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: 2.6.11-rc3: APM resume problems with USB

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4370] New: Pinnacle PCI SAT-TV card: cx24110

From: Stefan Schmidt <s.schmidt@mcbone.net>
Subject: (solved) Re: Fw: 2.6.11-mm2 weird ethernet RTTs

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4371] New: Battery doesn't work after suspend

Subject: http://lkml.org/lkml/2005/3/14/107
From: =?ISO-8859-1?Q?Feh=E9r_J=E1nos?= <feher.janos@mindworks.hu>

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4372] New: unplugging stv680-based pencam while in

From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [Bug 4293] mandatory locking fails on tmpfs

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4373] New: USB DVDRW hangs during burning or

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4374] New: bug in libata-core with sata_sil

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4375] New: Touchpad & Keyboard freeze

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4376] New: compat_ioctls for joystick

Subject: 
From: buakaw@buakaw.homelinux.net

From: viking <viking@flying-brick.caverock.net.nz>
Subject: USB mouse hiccups (was RFD: Kernel release numbering)

From: Neil Whelchel <koyama@firstlight.net>
Subject: SATA Promise TX4 Crash

From: Ron Gage <ron@rongage.org>
Subject: Major problem with PCMCIA/Yenta system

From: Patrick McFarland <pmcfarland@downeast.net>
Subject: alsa es1371's joystick functionality broken in 2.6.11-mm4

From: bugme-daemon@osdl.org
Subject: [Bug 4353] large pages not getting used when DB2 is tested with large page enabled

Subject: Problems with connect/disconnect cycles
From: Norbert Preining <preining@logic.at>

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4378] New: Intel 915GM not supported by Kernel

From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Fw: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4

From: Jonas Oreland <jonas.oreland@mysql.com>
Subject: Re: Major problem with PCMCIA/Yenta system

Subject: [CHECKER] ext3 bug in ftruncate() with O_SYNC?
From: Ben Pfaff <blp@cs.stanford.edu>

From: Dmitry Antipov <dmitry.antipov@mail.ru>
Subject: Radeonfb blanks the screen / hangs the system with 2.6.11

From: bugme-daemon@osdl.org
Subject: [Bug 4377] New: Severe memory leak issue

From: bugme-daemon@osdl.org
Subject: [Bugme-new] [Bug 4379] New: Default sampling rates for ondemand

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Fw: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4

