Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWEWCzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWEWCzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 22:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEWCzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 22:55:14 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:37318 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751192AbWEWCzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 22:55:13 -0400
Message-ID: <4472798A.20601@stesmi.com>
Date: Tue, 23 May 2006 04:55:06 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuri Jawad <lkml@jawad.org>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0605230407320.25860@pc>
In-Reply-To: <Pine.LNX.4.64.0605230407320.25860@pc>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig8983730C84AF9875987D403F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8983730C84AF9875987D403F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nuri Jawad wrote:
> Hi,
> just wanted to remark that I never liked that bzip was replaced by bzip2
> (were there license issues?) since bzip's compression was/is often
> stronger:

bzip was (possibly) infringing a patent so a method bzip used was
removed and subsequently bzip2 was created.

http://lists.debian.org/debian-devel/1997/12/msg00778.html

// Stefan

--------------enig8983730C84AF9875987D403F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEcnmPBrn2kJu9P78RA9QpAKCKHEf2PV6bC8yKLG8YONKHU2UI9gCfQ3Et
hTnBArPgWF04Sp9xh6zNIRo=
=ZB80
-----END PGP SIGNATURE-----

--------------enig8983730C84AF9875987D403F--
