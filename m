Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSJ1WLY>; Mon, 28 Oct 2002 17:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJ1WK7>; Mon, 28 Oct 2002 17:10:59 -0500
Received: from dsl-212-144-218-082.arcor-ip.net ([212.144.218.82]:27628 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S261570AbSJ1WJm>;
	Mon, 28 Oct 2002 17:09:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmx.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What does "hdX: CHECK for good STATUS" mean?
Date: Mon, 28 Oct 2002 23:15:59 +0100
User-Agent: KMail/1.4.1
References: <200210282247.37737.kiza@gmx.net> <1035843617.3552.67.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1035843617.3552.67.camel@irongate.swansea.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210282315.59281.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 28 October 2002 23:20, you wrote:
> On Mon, 2002-10-28 at 21:47, Oliver Feiler wrote:
> > Btw, why is the drive not set to UDMA(33) on boot (like the other 80 GB
> > Samsung drive)? I haven't found the drive in the ida-dma.c UDMA
> > blacklists. Could this be some braindead BIOS thing? I had to flash a
> > beta BIOS (Asus P5A-B) to get the board to boot with the 80 GB disks at
> > all.
>
> Because there are known problems with some combinations of WD drives and
> Ali controllers.

So this is just a "better be safe than sorry" thing? Obviously my data 
survived since I copied ~60 GB onto the drive running in UDMA33 mode. :)

What kind of problems would that be? A long time ago I had a 1.2 GB WD drive 
where forcing any DMA mode would result in massive data shredding.
Meaning: once it works in UDMA there is nothing to worry about?

Thanks for the quick answer.
Oliver

- -- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9vbcfOpifZVYdT9IRAqT+AJ94LWLZwPTSh8huEx6PA0XeBLguGwCfRzgF
t23o4RL/gzqx8/g/UuVzjSc=
=SML7
-----END PGP SIGNATURE-----

