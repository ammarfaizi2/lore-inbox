Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbSL3CGV>; Sun, 29 Dec 2002 21:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSL3CGV>; Sun, 29 Dec 2002 21:06:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48090 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265872AbSL3CGT>; Sun, 29 Dec 2002 21:06:19 -0500
Date: Sun, 29 Dec 2002 18:14:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: kernel-janitors@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Current unclaimed 2.5 bugs on bugme.osdl.org
Message-ID: <129460000.1041214462@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a growing number of unclaimed bugs on bugme.osdl.org.
These have defaulted back to Khoa or myself, as the category does
not have an owner ... if anyone is interested in working on these,
that'd be a great help. Either just append comments to the bugs,
or contact me and I can reassign them to you if you're going to
work on them real soon (let me know your account name). Some may
be fixed already, and just need confirmation.

Thanks,

Martin.

ID Sev Owner State Result Summary
44 blo khoa@us.ibm.com OPEN radeonfb does not compile at all - seems 
incomplete? or w...
48 nor mbligh@aracnet.com OPEN APM suspend and PCMCIA not cooperating
49 nor mbligh@aracnet.com OPEN register_console() called in illegal context
54 nor mbligh@aracnet.com OPEN 100% reproduceable "null TTY for (####) in 
tty_fasync"
58 nor mbligh@aracnet.com OPEN OHCI-1394: sleeping function called from 
illegal context ...
69 nor mbligh@aracnet.com OPEN Framebuffer bug
72 nor khoa@us.ibm.com OPEN Framebuffer scrolls at the wrong times/places
79 nor khoa@us.ibm.com OPEN Framebuffer scrolling problem
94 nor mbligh@aracnet.com OPEN file remain locked after sapdb process exist.
104 nor khoa@us.ibm.com OPEN MIPS fails to build: asm/thread_info.h doesn't 
exist
110 nor khoa@us.ibm.com OPEN Current bk Linux-2.5, VFS Kernel Panic from 
Devfs + NO UN...
115 nor mbligh@aracnet.com OPEN Kernel modules won't load
117 nor mbligh@aracnet.com OPEN build failure: arch/ppc/kernel/process.c
118 blo mbligh@aracnet.com OPEN Load IDE-SCSI module causes OOPS in 2.5.49
122 nor mbligh@aracnet.com OPEN emu10k1 OSS troubles
134 nor mbligh@aracnet.com OPEN 2.5.50 breaks pcmcia cards
135 nor mbligh@aracnet.com OPEN SB16/Alsa doesn't work
138 nor khoa@us.ibm.com OPEN Build error: drivers/video/sis/sis_main.h:299: 
parse erro...
142 low mbligh@aracnet.com OPEN problem with ver_linux script and procps 
version
145 nor mbligh@aracnet.com OPEN ALSA: SB-AWE ISA detection fails
153 nor mbligh@aracnet.com OPEN compile failure on drivers/char/riscom8.c
154 nor mbligh@aracnet.com OPEN compile failure on drivers/char/esp.c
155 nor mbligh@aracnet.com OPEN compile failure on drivers/char/specialix.c
157 hig mbligh@aracnet.com OPEN Makefile bug? sound/synth/emux/built-in.o
158 nor mbligh@aracnet.com OPEN depmod should be in README
159 nor mbligh@aracnet.com OPEN compile failure on 
drivers/isdn/i4l/isdn_net_lib.c
161 nor mbligh@aracnet.com OPEN VESAfb in 2.5 somehow influences X 
resolution.
162 nor khoa@us.ibm.com OPEN compile failure on 
drivers/media/video/bttv-cards.c
167 nor khoa@us.ibm.com OPEN compile failure on 
drivers/media/video/zr36120.c
168 nor khoa@us.ibm.com OPEN compile failure on 
drivers/media/video/saa7185.c
169 nor khoa@us.ibm.com OPEN compile failure on drivers/media/video/bt819.c
172 nor mbligh@aracnet.com OPEN tdfxfb.c can't be compiled
174 nor khoa@us.ibm.com OPEN link failure in function dvb_generic_ioctl: 
undefined ref...
179 nor mbligh@aracnet.com OPEN boot from 21 sec/track floppy
185 low mbligh@aracnet.com OPEN mwave init yields: bad: scheduling while 
atomic!
188 nor mbligh@aracnet.com OPEN proc_pid_readdir() holds the tasklist_lock 
for excessive ...
189 nor mbligh@aracnet.com OPEN sscanf in lib/vsprintf.c ignores field 
width for numeric ...
191 nor mbligh@aracnet.com OPEN Panic on shutdown
193 nor mbligh@aracnet.com OPEN sysrq umount bad ordering (real before loop)
195 nor khoa@us.ibm.com OPEN compile failure on 
drivers/media/video/zr36067.c
196 nor khoa@us.ibm.com OPEN compile failure on 
drivers/media/video/stradis.c
197 nor khoa@us.ibm.com OPEN compile failure on 
drivers/media/video/tda9887.o
202 nor mbligh@aracnet.com OPEN compile failure on 
drivers/net/irda/vlsi_ir.c
205 low mbligh@aracnet.com OPEN gpm mouse cursor flips chars on framebuffer 
console
206 nor mbligh@aracnet.com OPEN broken colors on framebuffer console
207 blo mbligh@aracnet.com OPEN Cirrus Logic Framebuffer -- Does not compile
209 nor mbligh@aracnet.com OPEN Matrox Framebuffer -- Does not compile

