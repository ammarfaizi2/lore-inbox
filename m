Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWIHXhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWIHXhr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 19:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWIHXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 19:37:47 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35246 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1751290AbWIHXhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 19:37:46 -0400
Message-ID: <4501FE9E.70608@web.de>
Date: Sat, 09 Sep 2006 01:37:02 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Auke Kok <auke-jan.h.kok@intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: e100 fails, eepro100 works
References: <450172F2.50308@web.de> <45018F76.5080403@intel.com>
In-Reply-To: <45018F76.5080403@intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig74A7B79D98563A6609FE1083"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig74A7B79D98563A6609FE1083
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Auke Kok wrote:
> Can you include a full `dmesg` and `lcpci -vv -s 00:12.0` ?
>=20
> Also you're using 3.5.10-k2, can you try the current git tree version
> instead? I can send you the e100.c if wanted.

Yes, please, to make sure that we'll really discuss the same version.
Will then try to collect the additional information on Monday.

Jan


--------------enig74A7B79D98563A6609FE1083
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFAf6eniDOoMHTA+kRAiX7AJ9bK3NOxXNP2nJDsjPBH168UG11agCfcD2h
I1EFWd8Phvxww4bGniQ/pW4=
=GLo8
-----END PGP SIGNATURE-----

--------------enig74A7B79D98563A6609FE1083--
