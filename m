Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVCELu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVCELu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 06:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVCELu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 06:50:59 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:59041 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262844AbVCELuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 06:50:51 -0500
Message-ID: <42299D31.7020901@arcor.de>
Date: Sat, 05 Mar 2005 12:51:13 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050222)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] nicksched for 2.6.11
References: <4225A020.5060001@yahoo.com.au>
In-Reply-To: <4225A020.5060001@yahoo.com.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFCEA3653E467665D6E27C2C2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFCEA3653E467665D6E27C2C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nick Piggin schrieb:
> I've had a few queries about this, so by "popular" demand, I've
> put my latest nicksched stuff here:
>
> www.kerneltrap.org/~npiggin/2.6.11-nicksched.gz
>
> It includes all the multiprocessor stuff that's in -mm, and also
> my alternate scheduler policy.

Hi,

just to make sure, is it still advised to renice X when using your scheduler?

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enigFCEA3653E467665D6E27C2C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCKZ0xxU2n/+9+t5gRAl+BAJ0W+/GBLt9nTaUZAPi8ra9EI6uGDQCZAea/
pRxkDPDOEk1cj6wqYIcreb8=
=xhtQ
-----END PGP SIGNATURE-----

--------------enigFCEA3653E467665D6E27C2C2--
