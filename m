Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUKNExV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUKNExV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 23:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUKNExV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 23:53:21 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:52628 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261245AbUKNExR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 23:53:17 -0500
Message-ID: <4196E4B7.9070900@kolivas.org>
Date: Sun, 14 Nov 2004 15:53:11 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Enrico Bartky <DOSProfi@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New HDD (was RE: PROMISE Ultra133 TX2 (PDC20269))
References: <683978599@web.de>
In-Reply-To: <683978599@web.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3D5AB1E02E23F86B240D21CF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D5AB1E02E23F86B240D21CF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Enrico Bartky wrote:
> Now I have attached a 80 GB UDMA5 Disk. The hdparm putput says the right UDMA Mode (5). But the hdparm test, I run it 3 times, says 27 MByte/s!? Is that normal, or is my motherboard ( Gigabyte GA-5AA ) to old ( PCI Bus = 33 MHz ). In the manuel from promise there is it described that 33 MHz have bandwith of 133 MByte/s and with 66 MHz 266 MByte/s.
> 
> Can you help me, how can I get more transfer rates?

133 is the speed it can transfer the data over the wire. It does _not_ 
mean the speed the hard disk is capable of.

Cheers,
Con

--------------enig3D5AB1E02E23F86B240D21CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBluS6ZUg7+tp6mRURAqnjAJkB8UK2VQpLKUKFS++EHSFTue1MAwCeNjwO
one1Af9I/m3+w/rpoZj8OT0=
=If77
-----END PGP SIGNATURE-----

--------------enig3D5AB1E02E23F86B240D21CF--
