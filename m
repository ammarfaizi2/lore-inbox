Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313139AbSDINFB>; Tue, 9 Apr 2002 09:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313895AbSDINFA>; Tue, 9 Apr 2002 09:05:00 -0400
Received: from vivi.uptime.at ([62.116.87.11]:64477 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S313139AbSDINE6>;
	Tue, 9 Apr 2002 09:04:58 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <o.pitzeier@uptime.at>, <axp-kernel-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.9 and ABOVE
Date: Tue, 9 Apr 2002 15:04:19 +0200
Organization: =?US-ASCII?Q?UPtime_Systemlosungen?=
Message-ID: <003801c1dfc7$12ed1da0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after rebooting i can delete the directory...

i really do not understand it any more. :o)

> -----Original Message-----
> From: Oliver Pitzeier [mailto:o.pitzeier@uptime.at] 
> Sent: Tuesday, April 09, 2002 2:56 PM
> To: 'axp-kernel-list@redhat.com'
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: RE: Kernel 2.4.9 and ABOVE
> 
> 
> OK... I now run kernel 2.4.18 on my alpha with ext3.
> 
> I wanted to delete /usr/src/linux, because I want to 
> recompile it again with another kernel...
> 
> That's what I get. I really do not understand it anymore!
> I could cry! OK, I have already done it. :o)
> 
> [root@node1 src]# rm -Rf linux
> rm: cannot stat `linux/fs/hpfs': Input/output error
> rm: cannot change to directory `linux/fs/fat': Not a directory
> rm: cannot stat `linux/fs/autofs': Input/output error
> rm: cannot stat `linux/fs/efs': Input/output error
> rm: cannot stat `linux/fs/partitions': Input/output error
> rm: cannot stat `linux/fs/autofs4': Input/output error
> rm: cannot stat `linux/fs/ext3': Input/output error
> rm: cannot remove directory `linux/fs': Directory not empty
> rm: cannot stat `linux/lib': Input/output error
> rm: cannot stat `linux/include/asm-generic': Input/output error
> rm: cannot change to directory 
> `linux/include/asm-mips/baget': Not a directory
> rm: cannot stat `linux/include/asm-mips/ddb5xxx': Input/output error
> rm: cannot stat `linux/include/asm-mips/mips-boards': 
> Input/output error
> rm: cannot remove directory `linux/include/asm-mips': 
> Directory not empty
> rm: cannot stat `linux/include/scsi': Input/output error
> rm: cannot change to directory 
> `linux/include/asm-arm/arch-nexuspci': Not a directory
> rm: cannot stat `linux/include/asm-arm/arch-ebsa285': 
> Input/output error
> rm: cannot stat `linux/include/asm-arm/arch-shark': Input/output error
> rm: cannot change to directory 
> `linux/include/asm-arm/arch-l7200': Not a directory
> rm: cannot stat `linux/include/asm-arm/arch-anakin': 
> Input/output error
> rm: cannot remove directory `linux/include/asm-arm': 
> Directory not empty
> rm: cannot stat `linux/include/video': Input/output error
> rm: cannot stat `linux/include/pcmcia': Input/output error
> rm: cannot stat `linux/include/asm-ia64/sn': Input/output error
> rm: cannot remove directory `linux/include/asm-ia64': 
> Directory not empty
> rm: cannot change to directory `linux/include/asm-mips64': 
> Not a directory
> rm: cannot stat `linux/include/config/blk/dev/ataraid': 
> Input/output error
> rm: cannot stat `linux/include/config/blk/dev/3w/xxxx': 
> Input/output error
> rm: cannot remove directory 
> `linux/include/config/blk/dev/3w': Directory not empty
> rm: cannot remove directory `linux/include/config/blk/dev': 
> Directory not empty
> rm: cannot remove directory EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607322 
> `linux/include/cEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607323
> onfig/blk': DireEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607324 
> EXT3-fs error (device sd(8,18)): ext3_free_blocks: bit 
> already cleared for block 1607325
> 
> rm: cannot statEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607326  
> `linux/include/EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607327
> config/ip/nf': IEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607328 
> nput/output erroEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607329 r
> rm: cannot reEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607330 move 
> directory `EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607331 linux/include/coEXT3-fs 
> error (device sd(8,18)): ext3_free_blocks: bit already 
> cleared for block 1607332
> nfig/ip': DirectEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607333 ory 
> not empty rEXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607334
> m: cannot stat `EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607335 
> linux/include/coEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607337 
> nfig/idedma/pci'EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607338
> : Input/output eEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607339 rror
> rm: cannotEXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607340  remove directorEXT3-fs 
> error (device sd(8,18)): ext3_free_blocks: bit already 
> cleared for block 1607341 y `linux/includeEXT3-fs error 
> (device sd(8,18)): ext3_free_blocks: bit already cleared for 
> block 1607336 /config/idedma':EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607342  Directory not eEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607343 mpty
> rm: cannotEXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607344  stat `linux/incEXT3-fs 
> error (device sd(8,18)): ext3_free_blocks: bit already 
> cleared for block 1607345 lude/config/scsiEXT3-fs error 
> (device sd(8,18)): ext3_free_blocks: bit already cleared for 
> block 1607346
> /ncr53c8xx': InpEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607347 
> EXT3-fs error (device sd(8,18)): ext3_free_blocks: bit 
> already cleared for block 1607348
> 
> rm: cannot remoEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607349 ve 
> directory `liEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607350 
> nux/include/confEXT3-fs error (device sd(8,18)): 
> ext3_free_inode: bit already cleared for inode 800146
> ig/scsi': DirectEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607351 ory 
> not empty rEXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607352
> m: cannot stat `EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607353 
> linux/include/coEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607354
> nfig/elmc': InpuEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607355 t/output error
> rm: cannot stat EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607356 
> `linux/include/cEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607357
> onfig/8139': InpEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607358 
> EXT3-fs error (device sd(8,18)): ext3_free_blocks: bit 
> already cleared for block 1607359
> 
> rm: cannot statEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607360  
> `linux/include/EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607361
> config/dl2k': InEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607362 
> put/output errorEXT3-fs error (device sd(8,18)): 
> ext3_free_inode: bit already cleared for inode 800149
> 
> rm: cannot chaEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607363 nge 
> to directoryEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607364  
> `linux/include/EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607365
> config/myri': NoEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607366 t a 
> directory rEXT3-fs error (device sd(8,18)): ext3_free_inode: 
> bit already cleared for inode 800150
> m: cannot stat `EXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607367 
> linux/include/coEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607368
> nfig/pc110': InpEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607369 
> EXT3-fs error (device sd(8,18)): ext3_free_inode: bit already 
> cleared for inode 800151
> 
> rm: cannot stat `linux/include/EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 1607370
> config/input': IEXT3-fs error (device sd(8,18)): 
> ext3_free_blocks: bit already cleared for block 1607371 
> EXT3-fs error (device sd(8,18)): ext3_free_blocks: bit 
> already cleared for block 1607372 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607373 EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607374 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607375 EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607376 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607377 EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607378 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607379 EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607380 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607381 EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607383 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607384 EXT3-fs error (device sd(8,18)): ext3_free_blocks: 
> bit already cleared for block 1607385 EXT3-fs error (device 
> sd(8,18)): ext3_free_blocks: bit already cleared for block 
> 1607382 EXT3-fs error (device sd(8,18)): ext3_free_inode: bit 
> already cleared for inode 800152
> 
> > -----Original Message-----
> > From: axp-kernel-list-admin@redhat.com
> > [mailto:axp-kernel-list-admin@redhat.com] On Behalf Of 
> Oliver Pitzeier
> > Sent: Tuesday, April 09, 2002 2:34 PM
> > To: axp-kernel-list@redhat.com
> > Subject: RE: Kernel 2.4.9 and ABOVE
> > 
> > 
> > > And you don't get these FS errors when using other 
> kernels? Does the 
> > > system freeze up or continue as if nothing had happened? File 
> > > corruption? Disk continously thrashing?
> > 
> > it works perfektly as if nothing has happened.
> > with other kernels i don't get such errors...
> >  
> > > How old are the disk[s] that you have as it could (my guess) be 
> > > failing disks, because I believe I have seen something 
> like it when 
> > > the communication between disk and controller became troublesome, 
> > > ie. a bad disk.
> > 
> > the machines are very new and the disk also. the disk are
> > not older than a half year...
> > 
> > > Else, I have no idea of what it could be?
> > 
> > me too! :o)
> > 
> > however... i go on...
> > 
> > -Oliver
> > 
> > 
> > 
> > 
> > _______________________________________________
> > Axp-kernel-list mailing list
> > Axp-kernel-list@redhat.com
> > https://listman.redhat.com/mailman/listinfo/ax> p-kernel-list
> > 
> 


