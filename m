Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132683AbRDIEOq>; Mon, 9 Apr 2001 00:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132684AbRDIEO0>; Mon, 9 Apr 2001 00:14:26 -0400
Received: from anarchy.io.com ([199.170.88.101]:17696 "EHLO anarchy.io.com")
	by vger.kernel.org with ESMTP id <S132683AbRDIEOV>;
	Mon, 9 Apr 2001 00:14:21 -0400
Message-Id: <v01530501b6f6dc61c861@[206.224.82.121]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 8 Apr 2001 23:12:14 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: trag@io.com (Jeff Walther)
Subject: Fast & Wide chip info
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may already have this information, but in case this info will be useful
to someone, the data sheets for the successor (pin compatible) chip to the
SYMBIOS LOGIC 53C825A is here:
http://www.lsilogic.com/techlib/techdocs/storage_stand_prod/PCISCSICont/Chip
s/825A.BK.pdf

LSI Logic bought SYMBIOS several years ago.   Also SYMBIOS is the spinoff
name of NCR's semiconductor group.  So, for example, the NCR 53CF96 which
you'll find on the Power Mac 8100 became a SYMBIOS part and then became an
LSI Logic part.  I suspect that the 53CF96 was licensed and became the MESH
chip in later Macs.  I haven't had time to do a pinout comparison between
the 53CF96 and the MESH, but they're in the same package and on casual
inspection the hookups look similar.

Anyway, the 53C825 information is available there and LSI Logic claims to
have Linux drivers available for download, in case those weren't used when
support was added.

Jeff Walther

P.S.  Anyone have a Mac CPU daughter card slot pinout (x500 machines)?  I
just need about ten pins.  I have the rest figured out.  I'd be happy to
supply my Bandit chip pinout.


