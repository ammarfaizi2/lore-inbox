Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbULMTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbULMTnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbULMTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:40:57 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:12736 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261468AbULMS4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:56:00 -0500
Subject: Re: [openib-general] [PATCH][v3][17/21] Add IPoIB
	(IP-over-InfiniBand) driver
From: Tom Duffy <tduffy@sun.com>
To: Roland Dreier <roland@topspin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, openib-general@openib.org
In-Reply-To: <52mzwi58zj.fsf@topspin.com>
References: <20041213109.JT1ejUdkRIUXbWOm@topspin.com>
	 <1102963464.9258.11.camel@duffman>  <52mzwi58zj.fsf@topspin.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Yk6Oa+xZH+Icmf/OE6Jd"
Date: Mon, 13 Dec 2004 10:54:29 -0800
Message-Id: <1102964069.9258.20.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yk6Oa+xZH+Icmf/OE6Jd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-13 at 10:49 -0800, Roland Dreier wrote:
>     Tom> Is there a reason why you put this in in an earlier patch and
>     Tom> then take it out later?
>=20
> I guess the reasons are stupidity and bad patch scripts...
>=20
> Doesn't hurt for now, will be fixed in future versions.

Speaking of nits, there are also some formatting issues with the
Makefiles that changes in the later patches...

But, the end result is you get the "correct" formatting if you apply all
the patches.

-tduffy

--=-Yk6Oa+xZH+Icmf/OE6Jd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBveVkdY502zjzwbwRAkGbAJ9Y7nYIijNZSAB28LyYyB6UeuopUgCgokCn
V7J0vqX7XrxA2MFpGbBVJ2g=
=xZFZ
-----END PGP SIGNATURE-----

--=-Yk6Oa+xZH+Icmf/OE6Jd--
