Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRK1REy>; Wed, 28 Nov 2001 12:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRK1REo>; Wed, 28 Nov 2001 12:04:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43026 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274752AbRK1RE0>; Wed, 28 Nov 2001 12:04:26 -0500
Date: Wed, 28 Nov 2001 13:47:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.4.17-pre1 
Message-ID: <Pine.LNX.4.21.0111281340210.15491-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, 2.4.17-pre1 is out. Still going to the mirrors though, so please wait
a while if you haven't found a copy on your local mirror. 


pre1:

- Change USB maintainer 			(Greg Kroah-Hartman)
- Speeling fix for rd.c				(From Ralf Baechle's tree)
- Updated URL for bigphysmem patch in v4l docs  (Adrian Bunk)
- Add buggy 440GX to broken pirq blacklist 	(Arjan Van de Ven)
- Add new entry to Sound blaster ISAPNP list	(Arjan Van de Ven)
- Remove crap character from Configure.help	(Niels Kristian Bech Jensen)
- Backout erroneous change to lookup_exec_domain (Christoph Hellwig)
- Update osst sound driver to 1.65		(Willem Riede)
- Fix i810 sound driver problems		(Andris Pavenis)
- Add AF_LLC define in network headers		(Arnaldo Carvalho de Melo)
- block_size cleanup on some SCSI drivers	(Erik Andersen)
- Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
  modules
- Add ->show_options() to super_ops and 
  implement NFS method				(Alexander Viro)
- Updated i8k driver				(Massimo Dal Zoto)
- devfs update  				(Richard Gooch)


