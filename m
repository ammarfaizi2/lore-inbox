Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSAHAv7>; Mon, 7 Jan 2002 19:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSAHAvu>; Mon, 7 Jan 2002 19:51:50 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34827 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287513AbSAHAvj>; Mon, 7 Jan 2002 19:51:39 -0500
Date: Mon, 7 Jan 2002 21:38:17 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.18-pre2
Message-ID: <Pine.LNX.4.21.0201072130170.18722-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes pre2.


pre2: 

- APIC LVTERR fixes				(Mikael Pettersson)
- Fix ppdev ioctl oops and deadlock		(Tim Waugh)
- parport fixes					(Tim Waugh)
- orinoco wireless driver update		(David Gibson)
- Fix oopsable race in binfmt_elf.c 		(Alexander Viro)
- Small sx16 driver bugfix			(Heinz-Ado Arnolds)
- sbp2 deadlock fix 				(Andrew Morton)
- Fix JFFS2 write error handling		(David Woodhouse)
- Intermezzo update				(Peter J. Braam)
- Proper AGP support for Intel 830MP chipsets	(Nicolas Aspert)
- Alpha fixes					(Jay Estabrook)
- 53c700 SCSI driver update			(James Bottomley)
- Fix coredump mmap_sem deadlock on IA64	(David Mosberger)
- 3ware driver update				(Adam Radford)
- Fix elevator insertion point on failed 
  request merge					(Jens Axboe)
- Remove bogus rpciod_tcp_dispatcher definition (David Woodhouse)
- Reiserfs fixes				(Oleg Drokin)
- de4x5 endianess fixes				(Kip Walker)
- ISDN CAPI cleanup				(Kai Germaschewski)
- Make refill_inactive() correctly account 
  progress					(me)

pre1:

- S390 merge					(IBM)
- SuperH merge					(SuperH team)
- PPC merge					(Benjamin Herrenschmidt)
- PCI DMA update				(David S. Miller)
- radeonfb update 				(Ani Joshi)
- aty128fb update				(Ani Joshi)
- Add nVidia GeForce3 support to rivafb		(Ani Joshi)
- Add PM support to opl3sa2			(Zwane Mwaikambo)
- Basic ethtool support for 3com, starfire
  and pcmcia net drivers			(Jeff Garzik)
- Add MII ethtool interface			(Jeff Garzik)
- starfire,sundance,dl2k,sis900,8139{too,cp},
  natsemi driver updates			(Jeff Garzik)
- ufs/minix: mark inodes as bad in case of read
  failure					(Christoph Hellwig)
- ReiserFS fixes				(Oleg Drokin)
- sonypi update					(Stelian Pop)
- n_hdlc update					(Paul Fulghum)
- Fix compile error on aty_base.c		(Tobias Ringstrom)
- Document cpu_to_xxxx() on kernel-hacking doc  (Rusty Russell)
- USB update					(Greg KH)
- Fix sysctl console loglevel bug on 
  IA64 (and possibly other archs)		(Jesper Juhl) 
- Update Athlon/VIA PCI quirks			(Calin A. Culianu)
- blkmtd update					(Simon Evans)
- boot protocol update (makes the highest 
  possible initrd address available to the 
  bootloader)					(H. Peter Anvin)
- NFS fixes					(Trond Myklebust)



