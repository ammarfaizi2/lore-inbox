Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284561AbRLESuQ>; Wed, 5 Dec 2001 13:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284565AbRLESuB>; Wed, 5 Dec 2001 13:50:01 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1555 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284561AbRLEStu>; Wed, 5 Dec 2001 13:49:50 -0500
Date: Wed, 5 Dec 2001 15:33:00 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.17-pre3
Message-ID: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes pre3.

People with Pentium Pro, please test if the workaround is really working
correctly... 

pre3:

- Enable ppro errata workaround                 (Dave Jones)
- Update tmpfs documentation                    (Christoph Rohland)
- Fritz!PCIv2 ISDN card support                 (Kai Germaschewski)
- Really apply ymfpci changes                   (Pete Zaitcev)
- USB update                                    (Greg KH)
- Adds detection of more eepro100 cards         (Troy A. Griffitts)
- Make ftruncate64() compliant with SuS         (Andrew Morton)
- ATI64 fb driver update                        (Geert Uytterhoeven)
- Coda fixes                                    (Jan Harkes)
- devfs update                                  (Richard Gooch)
- Fix ad1848 breakage in -pre2                  (Alan Cox)
- Network updates                               (David S. Miller)
- Add cramfs locking                            (Christoph Hellwig)
- Move locking of page_table_lock on expand_stack
  before accessing any vma field                (Manfred Spraul)
- Make time monotonous with gettimeofday        (Andi Kleen)
- Add MODULE_LICENSE(GPL) to ide-tape.c         (Mikael Pettersson)
- Minor cs46xx ioctl fix                        (Thomas Woller)


