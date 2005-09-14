Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932764AbVINVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbVINVrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbVINVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:47:55 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:27338 "EHLO
	av9-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S932764AbVINVry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:47:54 -0400
Message-ID: <43289A7E.1080307@fulhack.info>
Date: Wed, 14 Sep 2005 23:47:42 +0200
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5E23C2BAB8524DE2EDD123A3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E23C2BAB8524DE2EDD123A3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
> and that means that the merge window is closed. I've released a 
> 2.6.14-rc1, and we're now all supposed to help just clean up and fix 
> everything, and aim for a really solid 2.6.14 release.

My cardbus is acting funny. When I insert my netgear wg511 (prism54) the 
first time after booting 2.6.14-rc1 nothing happens. Nothing in dmesg, 
nothing nowhere. I remove it. Still nothing. Oh well. Inserting again. 
THEN it initializes and is working like it usually does.

2.6.13+Ivan's PCI resource patch worked allright.

I can live with this, but this is a regression.. I remember having 
exactly the same problem with some 2.4 kernel a few years back..

Any patch I should try backing out? Or some patch I should try?

--
Henrik Persson

--------------enig5E23C2BAB8524DE2EDD123A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDKJqDp5uk1YPOcmcRAuUuAJ9obIIqgJ2UwarZ+Uiol9cXCrxSqgCeKlgd
M1lac2vFxOuMhJiVR85dI+Q=
=IEwP
-----END PGP SIGNATURE-----

--------------enig5E23C2BAB8524DE2EDD123A3--
