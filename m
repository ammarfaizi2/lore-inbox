Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTLNQB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 11:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTLNQB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 11:01:28 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:43450 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262110AbTLNQB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 11:01:26 -0500
Message-ID: <3FDC8957.4000602@yahoo.es>
Date: Sun, 14 Dec 2003 11:01:27 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 vs 2.6
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet> <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com> <3FDC0BAC.8020909@mscc.huji.ac.il>
In-Reply-To: <3FDC0BAC.8020909@mscc.huji.ac.il>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96E8AF532C1A687C92A215CF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96E8AF532C1A687C92A215CF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Voicu Liviu wrote:
> My specs:
> Cpu:Athlon XP 2500+ BARTON {10x190}
> Mobo:EPOX 8RDA3 + NFORCE 2
> Ram:Corsair TWINX 512 3200LL{dual channel/11-3-2-2.0}
> Fan:Cooler Master +7
> Video:Hercules 3D Prophet 9600 PRO Radeon 128MB
> 
> My Hercules 3D Prophet 9600 PRO Radeon simply freezes my comp. with
> ati-drivers from ati.com so I need to press reset!(so I only can run
> console)
> My sound (nvidia on board) works very shitty and I have no control on
> it (level sound I mean).
> I was running 2.4.23 vanilla + lvm1 so I moved to 2.6 vanilla+lvm2 and
> now I can not move back
> 
> These are my biggest problems with 2.6.


Have you treid the in kernel DRI drivers?  They work with my Radeon
9000 on an nForce2.

Also, why can't you go back to 2.4.23?

-Roberto

--------------enig96E8AF532C1A687C92A215CF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/3IlXTfhoonTOp2oRAv3HAJ4r9/dlo+BqCd+6T9qOzGdGgS7ENgCeJ7kG
YywzWUVu2cFNEA3f7mSxHo8=
=X1Io
-----END PGP SIGNATURE-----

--------------enig96E8AF532C1A687C92A215CF--

