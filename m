Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290640AbSBYVgC>; Mon, 25 Feb 2002 16:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292217AbSBYVfq>; Mon, 25 Feb 2002 16:35:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:44047 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290640AbSBYVfa>; Mon, 25 Feb 2002 16:35:30 -0500
Date: Mon, 25 Feb 2002 17:26:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-pre1 
Message-ID: <Pine.LNX.4.21.0202251725110.31604-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes the first pre.

pre1:

- Add tape support to cciss driver			(Stephen Cameron)
- Add Permedia3 fb driver				(Romain Dolbeau)
- meye driver update					(Stelian Pop)
- opl3sa2 update					(Zwane Mwaikambo)
- JFFS2 update						(David Woodhouse)
- NBD deadlock fix					(Steven Whitehouse)
- Correct sys_shmdt() return value on failure		(Adam Bottchen)
- Apply the SET_PERSONALITY patch missing from 2.4.18 	(me)
- Alpha update						(Jay Estabrook)
- SPARC64 update					(David S. Miller)
- Fix potential blk freelist corruption			(Jens Axboe)
- Fix potential hpfs oops				(Chris Mason)
- get_request() starvation fix				(Andrew Morton)
- cramfs update						(Daniel Quinlan)
- Allow binfmt_elf as module				(Paul Gortmaker)
- ymfpci Configure.help update				(Pete Zaitcev)
- Backout one eepro100 change made in 2.4.18: it 
  was causing slowdowns on some cards			(Jeff Garzik)
- Tridentfb compilation fix				(Jani Monoses)
- Fix refcounting of directories on renames in tmpfs	(Christoph Rohland)
- Add Fujitsu notebook to broken APM implementation 
  blacklist						(Arjan Van de Ven)
- "do { ... } while(0)" cleanups on some fb drivers	(Geert Uytterhoeven)
- Fix natsemi's ETHTOOL_GLINK ioctl			(Tim Hockin)
- Fix clik! drive detection code in ide-floppy		(Paul Bristow)
- Add additional support for the 82801 I/O controller	(Wim Van Sebroeck)
- Remove duplicates in pci_ids.h			(Wim Van Sebroeck)



