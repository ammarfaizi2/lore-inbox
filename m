Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSLWCDo>; Sun, 22 Dec 2002 21:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbSLWCDo>; Sun, 22 Dec 2002 21:03:44 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:61151 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S266114AbSLWCDj>; Sun, 22 Dec 2002 21:03:39 -0500
Date: Sun, 22 Dec 2002 18:10:04 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: linux-kernel@vger.kernel.org
Subject: Weird freezes on 2.4.20-ck2 (without preempt)
Message-Id: <20021222181004.5bb18102.joshk@mspencer.net>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.cPJg/X9n.vERi/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.cPJg/X9n.vERi/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This could turn out to be OT, but here goes:

I run a 2.4.20-ck2 kernel with low latency enabled but without
preemptible support (my winmodem drivers don't support it.) It runs fine
but intermittently it freezes, sometimes as often as every three hours
or if i'm lucky it might remain up for about 6 hours.

I tried a vanilla 2.4.20 kernel and it does not freeze at all. There is
nothing in syslog that might show what is happening to the computer, no
oops, no nothing. The hard drive runs in DMA mode.

It froze even more often with 2.4.21-pre2.

Could this be a hardware problem? I'm sure the board is not overheating
(it is a laptop that is currently serving NAT.) This only started
happening recently, and I'm not sure what the cause might be.

Regards
-Josh

-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc

--=.cPJg/X9n.vERi/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+BnB/6TRUxq22Mx4RAhiZAJ4vDnqcAXhrSqpxASDEu7XDuUJn5ACdGu8E
yzrDOBw27S1VzJeyaAtRlWo=
=lmSz
-----END PGP SIGNATURE-----

--=.cPJg/X9n.vERi/--
