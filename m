Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTBUBAh>; Thu, 20 Feb 2003 20:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTBUBAh>; Thu, 20 Feb 2003 20:00:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:63421 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267091AbTBUBAc>; Thu, 20 Feb 2003 20:00:32 -0500
Date: Thu, 20 Feb 2003 17:01:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Stacy Woods <spwoods@us.ibm.com>
Subject: Bugs sitting in NEW state
Message-ID: <273640000.1045789303@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in NEW state for > 1 week and don't
seem to be actively worked on. They might be good candidates for
people to work on (*especially* ones owned by bugme-janitors),
but please check the bugs themselves for signs of activity.

http://bugme.osdl.org

  48  Drivers    PCMCIA     bugme-janitors@lists.osdl.org
APM suspend and PCMCIA not cooperating

  49  Drivers    Console    jsimmons@infradead.org
register_console() called in illegal context

  58  Drivers    IEEE1394   bcollins@debian.org
OHCI-1394: sleeping function called from illegal context ...

  69  Drivers    Console    jsimmons@infradead.org
Framebuffer bug

  72  Drivers    Console    jsimmons@infradead.org
Framebuffer scrolls at the wrong times/places

  79  Drivers    Console    jsimmons@infradead.org
Framebuffer scrolling problem

 104  Platform   MIPS       bugme-janitors@lists.osdl.org
MIPS fails to build: asm/thread_info.h doesn't exist

 110  File       Sys        bugme-janitors@lists.osdl.org
devfs Current bk Linux-2.5, VFS Kernel Panic from Devfs + NO UN...

 122  Platform   i386       rui.sousa@laposte.net
emu10k1 OSS troubles

 135  Drivers    Sound      bugme-janitors@lists.osdl.org
SB16/Alsa doesn't work

 142  Other      Other      bugme-janitors@lists.osdl.org
problem with ver_linux script and procps version

 145  Drivers    Sound      bugme-janitors@lists.osdl.org
ALSA: SB-AWE ISA detection fails

 153  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/riscom8.c

 154  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/esp.c

 155  Drivers    Serial     bugme-janitors@lists.osdl.org
compile failure on drivers/char/specialix.c

 160  Networki   Other      acme@conectiva.com.br
With 2 different nic on one system, dhcp configuration fails

 161  Drivers    Console    jsimmons@infradead.org
VESAfb in 2.5 somehow influences X resolution.

 179  File       Sys        bugme-janitors@lists.osdl.org
Other boot from 21 sec/track floppy

 189  Other      Other      bugme-janitors@lists.osdl.org
sscanf in lib/vsprintf.c ignores field width for numeric ...

 191  Platform   i386       akpm@digeo.com
Panic on shutdown

 193  Other      Other      bugme-janitors@lists.osdl.org
sysrq umount bad ordering (real before loop)

 205  Drivers    Console    jsimmons@infradead.org
gpm mouse cursor flips chars on framebuffer console

 207  Drivers    Console    jsimmons@infradead.org
Cirrus Logic Framebuffer -- Does not compile

 209  Drivers    Console    jsimmons@infradead.org
Matrox Framebuffer -- Does not compile

 228  Other      Other      bugme-janitors@lists.osdl.org
Make pdfdocs/psdocs/htmldoc fail in 2.5.54

 233  Drivers    Other      bugme-janitors@lists.osdl.org
cdrom/cdu31a.c Out of bounds according to Andy Chou <acc@...

 234  Drivers    Other      bugme-janitors@lists.osdl.org
cdrom/cdu31a.c Out of bounds according to Andy Chou <acc@...

 236  Drivers    Video      bugme-janitors@lists.osdl.org
media/video/bt856.c bounds error from Andy Chou <acc@cs.s...

 237  Drivers    Video      bugme-janitors@lists.osdl.org
media/video/c-qcam.c buffer out of bounds from Andy Chou ...

 238  Drivers    Video      bugme-janitors@lists.osdl.org
media/video/saa7134/saa7134-tvaudio.c buffer out of bound...

 239  Drivers    Video      bugme-janitors@lists.osdl.org
media/video/tvaudio.c buffer out of bounds from Andy Chou...

 240  Drivers    Parallel   bugme-janitors@lists.osdl.org
possible parport/probe.c off by one error from Andy Chou ...

 247  Drivers    Video      bugme-janitors@lists.osdl.org
Possible bug in fbgen.c from Stanford Checker

 248  Drivers    Video      bugme-janitors@lists.osdl.org
Possible bug in sstfb.c from Stanford Checker

 249  Drivers    Video      bugme-janitors@lists.osdl.org
uninitialized pointer in sstfb.c from Stanford Checker

 252  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds bug in sb_mixer.c from Stanford Ch...

 253  Drivers    Sound      bugme-janitors@lists.osdl.org
another possible out of bounds error in sb_mixer.c from S...

 254  Drivers    Sound      bugme-janitors@lists.osdl.org
One more possible out of bounds error in sb_mixer.c from ...

 255  Drivers    Sound      bugme-janitors@lists.osdl.org
Possible out of bounds error in ac97_patch.c from Stanfor...

 267  Other      Other      fdavis@si.rr.com
ver_linux script fails to give module-init-tools version

 283  Drivers    Serial     bugme-janitors@lists.osdl.org
Compile failure of drivers/char/isicom.c

 307  Drivers    Serial     bugme-janitors@lists.osdl.org
dangling else in drivers/char/generic_serial.c


