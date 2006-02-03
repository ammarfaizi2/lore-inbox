Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945907AbWBCXLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945907AbWBCXLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWBCXLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:11:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751201AbWBCXL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:11:27 -0500
Date: Fri, 3 Feb 2006 15:11:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       linux-fbdev-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: open bugzilla reports
Message-Id: <20060203151150.3d9aa8b3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a listing of the 263 bugzilla records which I felt worth keeping an
eye on.  It would be appreciated if the various maintenance teams could
take a look, close off any which are fixed and see if we can fix any which
aren't.

There's probably not a lot of point in replying to this email for any
particular bug: please do that within bugzilla and I can update this list
based upon any bugzilla updates.

If you do reply to this email, please trim the cc list to something
appropriate, thanks.


agp/drm/video/X
===============

[Bug 5163] x crashes at startup
	http://bugzilla.kernel.org/show_bug.cgi?id=5163

alsa
====

[Bug 5398] ES1988 Allegro-1 : No sound after boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5398
[Bug 5420] SiS CMI onboard sound card not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5420
[Bug 5523] Alsa Broken on 2.6.14
	http://bugzilla.kernel.org/show_bug.cgi?id=5523
[Bug 5568] opl3sa driver broken in 2.6.14
	http://bugzilla.kernel.org/show_bug.cgi?id=5568
[Bug 5824] EMU8000 does not depend on SB
	http://bugzilla.kernel.org/show_bug.cgi?id=5824
[Bug 5852] emu10k1 doesn't work
	http://bugzilla.kernel.org/show_bug.cgi?id=5852
[Bug 5126] No sound on Thinkpad X31 (Intel
	http://bugzilla.kernel.org/show_bug.cgi?id=5126
[Bug 5207] Sound system crashes when using the
	http://bugzilla.kernel.org/show_bug.cgi?id=5207
[Bug 5828] mplayer093 crash after update to
	http://bugzilla.kernel.org/show_bug.cgi?id=5828
[Bug 5892] Impossible to congigure hda_intel
	http://bugzilla.kernel.org/show_bug.cgi?id=5892
[Bug 5912] Can't record audio with mencoder
	http://bugzilla.kernel.org/show_bug.cgi?id=5912
[Bug 5621] no sound with snd-via82xx after resume
	http://bugzilla.kernel.org/show_bug.cgi?id=5621
[Bug 5628] snd_intel8x0 crash with Java application
	http://bugzilla.kernel.org/show_bug.cgi?id=5628
[Bug 5634] ALSA fails with SB16 value
	http://bugzilla.kernel.org/show_bug.cgi?id=5634
[Bug 5705] cmipci - No 5.1
	http://bugzilla.kernel.org/show_bug.cgi?id=5705
[Bug 5723] No sound with SB Live (Chip: SigmaTel
	http://bugzilla.kernel.org/show_bug.cgi?id=5723
[Bug 5726] soundblaster live 5.1 soundcard gets
	http://bugzilla.kernel.org/show_bug.cgi?id=5726
[Bug 5761] intel hda with some wrong
	http://bugzilla.kernel.org/show_bug.cgi?id=5761
[Bug 5763] ali5451 sound module hangs on swsusp
	http://bugzilla.kernel.org/show_bug.cgi?id=5763
[Bug 5792] ENS1371 codec read timeout
	http://bugzilla.kernel.org/show_bug.cgi?id=5792
[Bug 5937] regression: 2.6.15 and 2.6.16-rc1:
	http://bugzilla.kernel.org/show_bug.cgi?id=5937
[Bug 5986] speaker/headphone output selection
	http://bugzilla.kernel.org/show_bug.cgi?id=5986

block
=====

[Bug 5485] cdrom door locked when pktcdvd is
	http://bugzilla.kernel.org/show_bug.cgi?id=5485
[Bug 5900] Extremely slow sync with anticipatory
	http://bugzilla.kernel.org/show_bug.cgi?id=5900

bluetooth
=========

[Bug 5886] Immediate reboot when cancel file
	http://bugzilla.kernel.org/show_bug.cgi?id=5886
[Bug 5944] killing hciattach causes kernel oops if
	http://bugzilla.kernel.org/show_bug.cgi?id=5944
[Bug 5959] bluetooth CF card is broken by
	http://bugzilla.kernel.org/show_bug.cgi?id=5959

core kernel
===========

[Bug 5823] complete freeze
	http://bugzilla.kernel.org/show_bug.cgi?id=5823
[Bug 5042] setrlimit/getrlimit broken on 32-bit
	http://bugzilla.kernel.org/show_bug.cgi?id=5042
[Bug 5074] /sys/module/*/parameters/* not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5074
[Bug 5127] Lost ticks compensation fires when it
	http://bugzilla.kernel.org/show_bug.cgi?id=5127
[Bug 5138] 64bit put_unaligned/get_unaligned does
	http://bugzilla.kernel.org/show_bug.cgi?id=5138
[Bug 5877] Suspected scheduling starvation
	http://bugzilla.kernel.org/show_bug.cgi?id=5877
[Bug 3927] AMD64/ATI : timer is running twice as fast as it should
	http://bugzilla.kernel.org/show_bug.cgi?id=3927
[Bug 5645] [ELF] SIGKILL for n*0x1000 sized ELF
	http://bugzilla.kernel.org/show_bug.cgi?id=5645

cpufreq
=======

[Bug 5353] cpufreq_conservative: cpu always in
	http://bugzilla.kernel.org/show_bug.cgi?id=5353
[Bug 5495] changing cpu frequency causes fatal USB
	http://bugzilla.kernel.org/show_bug.cgi?id=5495
[Bug 5553] speedstep-smi fails to load if
	http://bugzilla.kernel.org/show_bug.cgi?id=5553
[Bug 5860] ondemand and speedstep-ich fail on
	http://bugzilla.kernel.org/show_bug.cgi?id=5860
[Bug 5122] cpufreq/powernowd is still not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5122
[Bug 5771] OOPS in libata when scaling cpu
	http://bugzilla.kernel.org/show_bug.cgi?id=5771
[Bug 5773] hang on reboot
	http://bugzilla.kernel.org/show_bug.cgi?id=5773
[Bug 5779] A very strange bug - possibly a BIOS
	http://bugzilla.kernel.org/show_bug.cgi?id=5779
[Bug 5934] System locks if cpufreq set to lowest
	http://bugzilla.kernel.org/show_bug.cgi?id=5934
[Bug 5951] Acer Aspire BIOS 3A29 reports to high
	http://bugzilla.kernel.org/show_bug.cgi?id=5951
[Bug 5985] speedstep-smi not detecting
	http://bugzilla.kernel.org/show_bug.cgi?id=5985
[Bug 6005] can't change cpu frequency on pentium M
	http://bugzilla.kernel.org/show_bug.cgi?id=6005

device mapper
=============

[Bug 5297] Memory problem with kcopyd under LVM2 lvremove execution and copying data at the same time.
	http://bugzilla.kernel.org/show_bug.cgi?id=5297
[Bug 5733] Oops writing to SATA RAID disks
	http://bugzilla.kernel.org/show_bug.cgi?id=5733
[Bug 5948] Oops when accessing loading IDE and
	http://bugzilla.kernel.org/show_bug.cgi?id=5948

drm
===

[Bug 5823] complete freeze
	http://bugzilla.kernel.org/show_bug.cgi?id=5823
[Bug 5641] Xinerama blocks chipset and GLX fails
	http://bugzilla.kernel.org/show_bug.cgi?id=5641
[Bug 5762] sigkill leaves process running with
	http://bugzilla.kernel.org/show_bug.cgi?id=5762

dvb
===

[Bug 5228] reboot fails on 2.6.13 when skystar2
	http://bugzilla.kernel.org/show_bug.cgi?id=5228
[Bug 5895] With DVB drivers enabled snd_87x (ALSA)
	http://bugzilla.kernel.org/show_bug.cgi?id=5895
	http://bugzilla.kernel.org/show_bug.cgi?id=5851
[Bug 5902] pluto2 driver in P4 celeron (128kB
	http://bugzilla.kernel.org/show_bug.cgi?id=5902
[Bug 5669] sound fix in SAA7134 tv-tuner
	http://bugzilla.kernel.org/show_bug.cgi?id=5669
[Bug 5699] saa7134 tuner no longer detected (i2c
	http://bugzilla.kernel.org/show_bug.cgi?id=5699
[Bug 5760] No sound with snd_intel8x0 & ALi M5455
	http://bugzilla.kernel.org/show_bug.cgi?id=5760
[Bug 5774] saa7134 module doesn't like suspend2
	http://bugzilla.kernel.org/show_bug.cgi?id=5774
[Bug 5941] DVB-T Pluto2: When changing from one
	http://bugzilla.kernel.org/show_bug.cgi?id=5941

fbdev
=====

[Bug 5482] Black screen with radeonfb
	http://bugzilla.kernel.org/show_bug.cgi?id=5482
[Bug 4869] Screen stays blank upon resume
	http://bugzilla.kernel.org/show_bug.cgi?id=4869
[Bug 5619] matroxfb: hard lock when switching
	http://bugzilla.kernel.org/show_bug.cgi?id=5619
[Bug 5769] Framebuffer breaks after kernel 2.6.12.6
	http://bugzilla.kernel.org/show_bug.cgi?id=5769
[Bug 5926] radeonfb somtimes hangs on x300 
	http://bugzilla.kernel.org/show_bug.cgi?id=5926

fs-misc
=======

[Bug 4821] Heavy load on smbfs gives
	http://bugzilla.kernel.org/show_bug.cgi?id=4821
[Bug 4822] smb_allocate_request() possible problem
	http://bugzilla.kernel.org/show_bug.cgi?id=4822
[Bug 4497] getdents gives empty/random result upon
	http://bugme.osdl.org/show_bug.cgi?id=4497
[Bug 5535] Encountered kernel oops with file
	http://bugzilla.kernel.org/show_bug.cgi?id=5535
[Bug 4585] EXT3 CORRUPTION ON BIG VOLUMES
	http://bugzilla.kernel.org/show_bug.cgi?id=4585
[Bug 5856] Oops when fs nearly full
	http://bugzilla.kernel.org/show_bug.cgi?id=5856
[Bug 5109] kernel BUG in hfsplus
	http://bugzilla.kernel.org/show_bug.cgi?id=5109
[Bug 5416] journal block not found
	http://bugzilla.kernel.org/show_bug.cgi?id=5416
[Bug 5615] odd cwd behavior
	http://bugzilla.kernel.org/show_bug.cgi?id=5615
[Bug 5739] nls_cp936 doesn't handle characters in
	http://bugzilla.kernel.org/show_bug.cgi?id=5739
[Bug 5750] NULL POINTER oops after CIFS automount
	http://bugzilla.kernel.org/show_bug.cgi?id=5750
[Bug 5079] Possible file date underflow on ext2/3
	http://bugzilla.kernel.org/show_bug.cgi?id=5079
[Bug 5954] Client performs retries of NLM_LOCK
	http://bugzilla.kernel.org/show_bug.cgi?id=5954
[Bug 5956] Linux client sets block=false in
	http://bugzilla.kernel.org/show_bug.cgi?id=5956
[Bug 5984] lockd kernel panic in
	http://bugzilla.kernel.org/show_bug.cgi?id=5984
[Bug 6002] quota + 2.6.15.1
	http://bugzilla.kernel.org/show_bug.cgi?id=6002

ieee1394
========

[Bug 4779] amd64: raw1394 returns EINVAL
	http://bugzilla.kernel.org/show_bug.cgi?id=4779
[Bug 5998] oops on mount "kernel access of bad
	http://bugzilla.kernel.org/show_bug.cgi?id=5998

input
=====

[Bug 5386] rmmod usbhid crashes
	http://bugzilla.kernel.org/show_bug.cgi?id=5386
[Bug 5408] Wrong keymapping for logitech cordless
	http://bugzilla.kernel.org/show_bug.cgi?id=5408
[Bug 5449] bug in psmouse.c "lost synchronization"
	http://bugzilla.kernel.org/show_bug.cgi?id=5449
[Bug 5475] USB mouse freezes in X
	http://bugzilla.kernel.org/show_bug.cgi?id=5475
[Bug 3830] Touchpad stopped working from 2.6.9 and beyond
	http://bugzilla.kernel.org/show_bug.cgi?id=3830
[Bug 5850] grip module crashes system since 2.6.15
	http://bugzilla.kernel.org/show_bug.cgi?id=5850
[Bug 5855] kde keeps displaying volume-osd
	http://bugzilla.kernel.org/show_bug.cgi?id=5855
[Bug 4981] changes in 2.6.12-rc1 causes ati-remote
	http://bugzilla.kernel.org/show_bug.cgi?id=4981
[Bug 5158] ps/2 keyboard on x86_64 does not work
	http://bugzilla.kernel.org/show_bug.cgi?id=5158
[Bug 5197] Alps pad fails to reenable dualpoint on
	http://bugzilla.kernel.org/show_bug.cgi?id=5197
[Bug 5233] usb hid 'relative' input events
	http://bugzilla.kernel.org/show_bug.cgi?id=5233
[Bug 5690] First key pressed never responds
	http://bugzilla.kernel.org/show_bug.cgi?id=5690
[Bug 5697] Input via atkbd.c and psmouse.c becomes
	http://bugzilla.kernel.org/show_bug.cgi?id=5697
[Bug 5780] multimedia keys shouldn't repead
	http://bugzilla.kernel.org/show_bug.cgi?id=5780
[Bug 5932] PS/2 keyboard does not work with
	http://bugzilla.kernel.org/show_bug.cgi?id=5932

isdn
====

[Bug 5064] Oops Unable to handle NULL pointer
	http://bugzilla.kernel.org/show_bug.cgi?id=5064

kbuild
======

[Bug 5756] ENHANCEMENT PATCH for
	http://bugzilla.kernel.org/show_bug.cgi?id=5756

mm
==

[Bug 5665] CPU lockup when hitting OOM on
	http://bugzilla.kernel.org/show_bug.cgi?id=5665
[Bug 5493] mprotect usage causing slow system performance and freezing
	http://bugzilla.kernel.org/show_bug.cgi?id=5493

net
===

[Bug 5306] Oops on IPv6 route lookup
	http://bugzilla.kernel.org/show_bug.cgi?id=5306
[Bug 5438] kernel BUG/Oops triggered by conntrack
	http://bugzilla.kernel.org/show_bug.cgi?id=5438
[Bug 5591] KERNEL: assertion
	http://bugzilla.kernel.org/show_bug.cgi?id=5591
[Bug 5857] errors in ppp
	http://bugzilla.kernel.org/show_bug.cgi?id=5857
[Bug 5869] After pon: Kernel BUG at
	http://bugzilla.kernel.org/show_bug.cgi?id=5869
[Bug 5156] llc2: llc_ui_bind() leaves llc->dev NULL
	http://bugzilla.kernel.org/show_bug.cgi?id=5156
[Bug 5610] IP MTU Path Discovery now working
	http://bugzilla.kernel.org/show_bug.cgi?id=5610
[Bug 5627] Network boot - IP-Config reports wrong
	http://bugzilla.kernel.org/show_bug.cgi?id=5627
[Bug 5672] cannot get socket once accept(2) has
	http://bugzilla.kernel.org/show_bug.cgi?id=5672
[Bug 5695] pppd hangs after disconnect on
	http://bugzilla.kernel.org/show_bug.cgi?id=5695
[Bug 5803] Bridge code Oops with 2.6.14.2
	http://bugzilla.kernel.org/show_bug.cgi?id=5803
[Bug 5936] Openswan tunnels + netfilter problem
	http://bugzilla.kernel.org/show_bug.cgi?id=5936
[Bug 5946] KERNEL: assertion
	http://bugzilla.kernel.org/show_bug.cgi?id=5946

netdev
======

[Bug 5280] Marvell Yukon E8053 pci-express LAN
	http://bugzilla.kernel.org/show_bug.cgi?id=5280
[Bug 5379] skge driver turns off 3C940
	http://bugzilla.kernel.org/show_bug.cgi?id=5379
[Bug 5527] new e1000 82541PI locks under load 
	http://bugme.osdl.org/show_bug.cgi?id=5527
[Bug 5806] Wake-On-LAN does not work on VIA
	http://bugzilla.kernel.org/show_bug.cgi?id=5806
[Bug 5810] e100 IRQ problem
	http://bugzilla.kernel.org/show_bug.cgi?id=5810
[Bug 5827] pppd with MPPE fails
	http://bugzilla.kernel.org/show_bug.cgi?id=5827
[Bug 5839] uli526x partially recognizing interface
	http://bugzilla.kernel.org/show_bug.cgi?id=5839
[Bug 5842] ipw2100 driver + WPA encryption = crash
	http://bugzilla.kernel.org/show_bug.cgi?id=5842
[Bug 5870] SiS 190 doesn't download files
	http://bugzilla.kernel.org/show_bug.cgi?id=5870
[Bug 4982] Usenet gateway crashes under heavy
	http://bugzilla.kernel.org/show_bug.cgi?id=4982
[Bug 5030] kernel: eth1: Oversized Ethernet frame
	http://bugzilla.kernel.org/show_bug.cgi?id=5030
[Bug 5039] high cpu usage (softirq takes 50% all
	http://bugzilla.kernel.org/show_bug.cgi?id=5039
[Bug 5080] bonding related oops on boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5080
[Bug 5137] r8169 - network dies.
	http://bugzilla.kernel.org/show_bug.cgi?id=5137
[Bug 5204] sk98lin driver blocks NIC for BIOS/dual
	http://bugzilla.kernel.org/show_bug.cgi?id=5204
[Bug 5890] Driver sk98lin not working (no
	http://bugzilla.kernel.org/show_bug.cgi?id=5890
[Bug 5896] [sk98lin] vpd errors on dfi lanparty ut
	http://bugzilla.kernel.org/show_bug.cgi?id=5896
[Bug 5609] e1000, 2.6.1[34] - WOL not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5609
[Bug 5681] 8139cp has broken suspend/resume
	http://bugzilla.kernel.org/show_bug.cgi?id=5681
[Bug 5698] IPW2100 driver loosing association with
	http://bugzilla.kernel.org/show_bug.cgi?id=5698
[Bug 5711] ipw2200: NETDEV_TX_BUSY returned;
	http://bugzilla.kernel.org/show_bug.cgi?id=5711
[Bug 5714] can't configure IPW2200 Monitor mode
	http://bugzilla.kernel.org/show_bug.cgi?id=5714
[Bug 5718] NIC dont work with Toshiba Satellite
	http://bugzilla.kernel.org/show_bug.cgi?id=5718
[Bug 5924] Starfire interface stopped working
	http://bugzilla.kernel.org/show_bug.cgi?id=5924
[Bug 5927] TG3 driver unable to get memory resource
	http://bugzilla.kernel.org/show_bug.cgi?id=5927
[Bug 5785] allocation failure and dead skge
	http://bugzilla.kernel.org/show_bug.cgi?id=5785
[Bug 5940] ipw2100 version incompatible with
	http://bugzilla.kernel.org/show_bug.cgi?id=5940
[Bug 5947] r8169 Losing some ticks
	http://bugzilla.kernel.org/show_bug.cgi?id=5947
[Bug 5965] Problems with Intel Pro 1000 (82545GM)
	http://bugzilla.kernel.org/show_bug.cgi?id=5965
[Bug 5973] Yukon / Marvell driver in kernel
	http://bugzilla.kernel.org/show_bug.cgi?id=5973
[Bug 5992] r8169 driver - no network connection,
	http://bugzilla.kernel.org/show_bug.cgi?id=5992

parport
=======

[Bug 5796] If the printer is turned off,
	http://bugzilla.kernel.org/show_bug.cgi?id=5796
[Bug 4983] Paralell ZIP disappearing
	http://bugzilla.kernel.org/show_bug.cgi?id=4983

pata
====

[Bug 5472] pktcdvd avoid to read iso9660 DVDs.
	http://bugzilla.kernel.org/show_bug.cgi?id=5472
[Bug 5577] permanent compact flash change
	http://bugzilla.kernel.org/show_bug.cgi?id=5577
[Bug 5581] CD DMA timout panic in ide-iops.c
	http://bugzilla.kernel.org/show_bug.cgi?id=5581
[Bug 5371] Really slow dvd burning
	http://bugzilla.kernel.org/show_bug.cgi?id=5371
[Bug 5880] Transcend CF pcmcia card no longer works
	http://bugzilla.kernel.org/show_bug.cgi?id=5880
[Bug 5159] BUG: soft lockup detected on CPU#0!
	http://bugzilla.kernel.org/show_bug.cgi?id=5159
[Bug 5911] siimage.c interrupts screaming
	http://bugzilla.kernel.org/show_bug.cgi?id=5911
[Bug 5919] kernel: ata1: command 0x25 timeout,
	http://bugzilla.kernel.org/show_bug.cgi?id=5919
[Bug 5599] HDIO_GET_ACOUSTIC failed: Inappropriate
	http://bugzilla.kernel.org/show_bug.cgi?id=5599
[Bug 5673] hda and ide0 errors on resume from acpi
	http://bugzilla.kernel.org/show_bug.cgi?id=5673
[Bug 5759] ATIIXP driver does not detect some MDMA
	http://bugzilla.kernel.org/show_bug.cgi?id=5759
[Bug 5786] DMA access to CD-writer hangs IDE bus
	http://bugzilla.kernel.org/show_bug.cgi?id=5786
[Bug 5928] problem reading files with ide-tape
	http://bugzilla.kernel.org/show_bug.cgi?id=5928
[Bug 5929] DMA not working on ATAPI HL-DT-ST
	http://bugzilla.kernel.org/show_bug.cgi?id=5929
[Bug 5938] Boot stalls on loading ide-cd. Crashed
	http://bugzilla.kernel.org/show_bug.cgi?id=5938
[Bug 5901] Resume from suspend-to-memory worked in
	http://bugzilla.kernel.org/show_bug.cgi?id=5901

pci
===

[Bug 5587] Toshiba M200 PCI fails to allocate
	http://bugzilla.kernel.org/show_bug.cgi?id=5587
[Bug 5736] pci broken on PIIX/ICH laptop
	http://bugzilla.kernel.org/show_bug.cgi?id=5736

pcmcia/cardbus
==============

[Bug 5569] xirc2ps_cs based pcmcia card stopped
	http://bugzilla.kernel.org/show_bug.cgi?id=5569
[Bug 5062] kernel preemption breaks in several ways
	http://bugzilla.kernel.org/show_bug.cgi?id=5062
[Bug 5848] pcmcia novatel merlin u530 not working
	http://bugzilla.kernel.org/show_bug.cgi?id=5848

power management
================

[Bug 4919] APM resume: freeze at disk access
	http://bugzilla.kernel.org/show_bug.cgi?id=4919

powerpc
=======

[Bug 5679] Kernel fails to boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5679
[Bug 5689] java crashes "JVMDG218: JVM is not
	http://bugzilla.kernel.org/show_bug.cgi?id=5689

sata
====

[Bug 4860] sata_sx4 doesn't recognize Promise
	http://bugzilla.kernel.org/show_bug.cgi?id=4860
[Bug 4920] IDE CD Driver not able to read audio
	http://bugzilla.kernel.org/show_bug.cgi?id=4920
[Bug 5533] sata_via unable to see my Plextor 716SA
	http://bugzilla.kernel.org/show_bug.cgi?id=5533
[Bug 5586] mv_sata doesn't detect any disk and
	http://bugzilla.kernel.org/show_bug.cgi?id=5586
[Bug 5589] libata - Oops when sata drive under load
	http://bugzilla.kernel.org/show_bug.cgi?id=5589
[Bug 5798] PLEXTOR 716sa SATA
	http://bugzilla.kernel.org/show_bug.cgi?id=5798
[Bug 5863] ata_piix disables SATA drives at boot
	http://bugzilla.kernel.org/show_bug.cgi?id=5863
[Bug 4968] sata_nv buffer I/O errors
	http://bugzilla.kernel.org/show_bug.cgi?id=4968
[Bug 5047] sata hangs (Silicon Image and seagate
	http://bugzilla.kernel.org/show_bug.cgi?id=5047
[Bug 5905] status=0x50 errors with SATA drives
	http://bugzilla.kernel.org/show_bug.cgi?id=5905
[Bug 5914] recent davej kernels (2.6.15-git*-base)
	http://bugzilla.kernel.org/show_bug.cgi?id=5914
[Bug 5596] Kernel panic on sata_mv driver durring
	http://bugzilla.kernel.org/show_bug.cgi?id=5596
[Bug 5654] Serial Ata 3512a in 2.6.14
	http://bugzilla.kernel.org/show_bug.cgi?id=5654
[Bug 5664] Data Corruption with Kernel Version
	http://bugzilla.kernel.org/show_bug.cgi?id=5664
[Bug 5700] Panic: Fatal exception in interrupt w/
	http://bugzilla.kernel.org/show_bug.cgi?id=5700
[Bug 5709] sata_promise: missing pci id for
	http://bugzilla.kernel.org/show_bug.cgi?id=5709
[Bug 5721] libata does not report detailed info in
	http://bugzilla.kernel.org/show_bug.cgi?id=5721
[Bug 5722] Buffer I/O error on device sr0,
	http://bugzilla.kernel.org/show_bug.cgi?id=5722
[Bug 5922] sata_uli fails to see harddisks on PCI
	http://bugzilla.kernel.org/show_bug.cgi?id=5922
[Bug 5789] ATAPI isn't working on sata-via
	http://bugzilla.kernel.org/show_bug.cgi?id=5789
[Bug 5931] Oops when calling hddtemp on sata drive
	http://bugzilla.kernel.org/show_bug.cgi?id=5931
[Bug 5969] IDE driver can't detect any hdd through
	http://bugzilla.kernel.org/show_bug.cgi?id=5969
[Bug 5948] Oops when accessing SATA with device mapper on AMD 64 X2
	http://bugzilla.kernel.org/show_bug.cgi?id=5948
[Bug 5987] Oopses at boot,
	http://bugzilla.kernel.org/show_bug.cgi?id=5987
[Bug 5995] RAID with SATA fails on drive un-plug
	http://bugzilla.kernel.org/show_bug.cgi?id=5995

scsi
====

[Bug 4880] dpt_i2o.c does not register itself with
	http://bugzilla.kernel.org/show_bug.cgi?id=4880
[Bug 4929] problem with aic7xxx driver on 2.6.x
	http://bugzilla.kernel.org/show_bug.cgi?id=4929
[Bug 5268] aic79xx scsi driver causing system to
	http://bugzilla.kernel.org/show_bug.cgi?id=5268
[Bug 5378] aic7xxx deadlock/freeze on Adaptec
	http://bugzilla.kernel.org/show_bug.cgi?id=5378
[Bug 5440] Perc4 megaraid: module doesn't detect
	http://bugzilla.kernel.org/show_bug.cgi?id=5440
[Bug 5531] SCSI SR_MOD Doesn't Recognize CD after
	http://bugzilla.kernel.org/show_bug.cgi?id=5531
[Bug 5566] scsi_eh_x/scsi_wq_x "zombie" processes
	http://bugzilla.kernel.org/show_bug.cgi?id=5566
[Bug 5795] kernel boot oops
	http://bugzilla.kernel.org/show_bug.cgi?id=5795
[Bug 5808] aic7xxx - half speed/frequency
	http://bugzilla.kernel.org/show_bug.cgi?id=5808
[Bug 5154] 2.6.13 crashes on heavy used server
	http://bugzilla.kernel.org/show_bug.cgi?id=5154
[Bug 5887] Erratic messages for a CDROM
	http://bugzilla.kernel.org/show_bug.cgi?id=5887
[Bug 5910] tar to tape-drive kills keyboard,
	http://bugzilla.kernel.org/show_bug.cgi?id=5910
[Bug 5921] SCSI bus crash when formating CDRW
	http://bugzilla.kernel.org/show_bug.cgi?id=5921
[Bug 5656] system freeze
	http://bugzilla.kernel.org/show_bug.cgi?id=5656
=?iso-8859-1?q?=5BBug_5659=5D_New=3A_Can=B4t_copy_fi?=
	http://bugzilla.kernel.org/show_bug.cgi?id=5659
[Bug 5685] Symbios Logic 53c1030 Driver Not Running
	http://bugzilla.kernel.org/show_bug.cgi?id=5685
[Bug 5712] mptscsih: ioc0: task abort messages at
	http://bugzilla.kernel.org/show_bug.cgi?id=5712
[Bug 5735] System boot hangs Adaptec 2100S card
	http://bugzilla.kernel.org/show_bug.cgi?id=5735
[Bug 5738] ahci + software raid (intel E7221,
	http://bugzilla.kernel.org/show_bug.cgi?id=5738
[Bug 5755] 16 byte CDBs not enabled in Adaptec
	http://bugzilla.kernel.org/show_bug.cgi?id=5755
[Bug 5775] when a scsi device is plugged in again,
	http://bugzilla.kernel.org/show_bug.cgi?id=5775
[Bug 5776] initio: Kernel crash while launching
	http://bugzilla.kernel.org/show_bug.cgi?id=5776
[Bug 5953] easyRAID F8 IDE2SCSI adaptor problems
	http://bugzilla.kernel.org/show_bug.cgi?id=5953
[Bug 5955] Speed negotiation between scsi driver
	http://bugzilla.kernel.org/show_bug.cgi?id=5955

sensors
=======
[Bug 5981] it87 chassis fan speed not reported,
	http://bugzilla.kernel.org/show_bug.cgi?id=5981

serial
======

[Bug 5832] Enabling ACPI Plug and Play in kernels
	http://bugzilla.kernel.org/show_bug.cgi?id=5832
[Bug 5875] quad RS232 port card detected as 8,
	http://bugzilla.kernel.org/show_bug.cgi?id=5875
[Bug 5942] serial driver gives up and we get IRQ3
	http://bugzilla.kernel.org/show_bug.cgi?id=5942
[Bug 5958] CF bluetooth card oopses machine when
	http://bugzilla.kernel.org/show_bug.cgi?id=5958

suspend/resume
==============

[Bug 5528] iBook 14'' 1.42 Ghz sleep,
	http://bugme.osdl.org/show_bug.cgi?id=5528
[Bug 5945] "scheduling while atomic" during wakeup
	http://bugzilla.kernel.org/show_bug.cgi?id=5945

swsusp
======
[Bug 5671] pci=routeirq required for successful
	http://bugzilla.kernel.org/show_bug.cgi?id=5671

time management
===============

[Bug 5366] synchronize_tsc_bp can zero the TSC
	http://bugzilla.kernel.org/show_bug.cgi?id=5366
[Bug 5740] tsc ocassionally counts back with dual
	http://bugzilla.kernel.org/show_bug.cgi?id=5740

usb
=====

[Bug 4776] uhci_hcd: host controller halted,
	http://bugzilla.kernel.org/show_bug.cgi?id=4776
[Bug 4916] USB mouse stops working after inserting
	http://bugzilla.kernel.org/show_bug.cgi?id=4916
[Bug 4917] Lacie 250Go USB
	http://bugzilla.kernel.org/show_bug.cgi?id=4917
[Bug 5349] USB card detected,
	http://bugzilla.kernel.org/show_bug.cgi?id=5349
[Bug 5541] oops in drivers/usb/ipaq when
	http://bugzilla.kernel.org/show_bug.cgi?id=5541
[Bug 5835] High Speed USB devices don't work when
	http://bugzilla.kernel.org/show_bug.cgi?id=5835
[Bug 5836] USB disconnect/connect continuously
	http://bugzilla.kernel.org/show_bug.cgi?id=5836
[Bug 4966] ehci_hcd on x86_64 causes more than
	http://bugzilla.kernel.org/show_bug.cgi?id=4966
[Bug 5086] unplugging webcam when stv680 is in use
	http://bugzilla.kernel.org/show_bug.cgi?id=5086
[Bug 5143] USB HID,
	http://bugzilla.kernel.org/show_bug.cgi?id=5143
[Bug 5164] pl2303 when unplugged while device is
	http://bugzilla.kernel.org/show_bug.cgi?id=5164
[Bug 5215] USB OHCI pci card can not enable usb
	http://bugzilla.kernel.org/show_bug.cgi?id=5215
[Bug 5253] usb storage disappears after hotplug
	http://bugzilla.kernel.org/show_bug.cgi?id=5253
[Bug 5874] 2.6.15: USB vibration feedback gamepad
	http://bugzilla.kernel.org/show_bug.cgi?id=5874
[Bug 5876] w9968cf oopses with creative webcam go
	http://bugzilla.kernel.org/show_bug.cgi?id=5876
[Bug 5913] USB enclosure doesn't work
	http://bugzilla.kernel.org/show_bug.cgi?id=5913
[Bug 5920] USB vibration feedback gamepad problem
	http://bugzilla.kernel.org/show_bug.cgi?id=5920
[Bug 5600] suspend to disk and suspend to RAM
	http://bugzilla.kernel.org/show_bug.cgi?id=5600
[Bug 5640] System doesn' shutdown when a device is
	http://bugzilla.kernel.org/show_bug.cgi?id=5640
[Bug 5642] ohci_hcd temporary freeze on nForce4
	http://bugzilla.kernel.org/show_bug.cgi?id=5642
[Bug 5652] Built in card reader doesn't work
	http://bugzilla.kernel.org/show_bug.cgi?id=5652
[Bug 5682] USB hard drive disconnects
	http://bugzilla.kernel.org/show_bug.cgi?id=5682
[Bug 5684] VT6205-DevH SD card reader (USB) will
	http://bugzilla.kernel.org/show_bug.cgi?id=5684
[Bug 5730] FTDI USB serial adaptor problems
	http://bugzilla.kernel.org/show_bug.cgi?id=5730
[Bug 5742] Suspend resume does not work on
	http://bugzilla.kernel.org/show_bug.cgi?id=5742
[Bug 5744] usbnet connection to sharp zaurus
	http://bugzilla.kernel.org/show_bug.cgi?id=5744
[Bug 5753] Problem initializing CSR bluetooth
	http://bugzilla.kernel.org/show_bug.cgi?id=5753
[Bug 5777] ehci-hcd re-load necessary to use kbd
	http://bugzilla.kernel.org/show_bug.cgi?id=5777
[Bug 5788] ASUS A6k Notebook hangs on boot while
	http://bugzilla.kernel.org/show_bug.cgi?id=5788
[Bug 5935] boot process hangs in pci_init,
	http://bugzilla.kernel.org/show_bug.cgi?id=5935
[Bug 5967] Novatel Wireless CDMA Card (V620)
	http://bugzilla.kernel.org/show_bug.cgi?id=5967
[Bug 5974] if usb-storage atached - ps/2 keyboard
	http://bugzilla.kernel.org/show_bug.cgi?id=5974
[Bug 5997] usbhid driver disable the Mouse and
	http://bugzilla.kernel.org/show_bug.cgi?id=5997

x86
===

[Bug 5565] Guess of i386 APIC PTE area scribble
	http://bugzilla.kernel.org/show_bug.cgi?id=5565
[Bug 5620] gcc miscompiles code using i386
	http://bugzilla.kernel.org/show_bug.cgi?id=5620
[Bug 5636] Totally bogus BogoMips when
	http://bugzilla.kernel.org/show_bug.cgi?id=5636

x86_64
======

[Bug 5343] IOMMU setup broken 2.6.13.2 -> 2.6.14-rc2
	http://bugzilla.kernel.org/show_bug.cgi?id=5343
[Bug 5522] Timer going backward on an AMD64 dual
	http://bugzilla.kernel.org/show_bug.cgi?id=5522
[Bug 5752] Dual Opteron - Memory missing
	http://bugzilla.kernel.org/show_bug.cgi?id=5752

