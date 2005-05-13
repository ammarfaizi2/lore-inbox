Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVEMSig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVEMSig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVEMSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:38:35 -0400
Received: from matheson.swishmail.com ([209.10.110.114]:707 "EHLO
	matheson.swishmail.com") by vger.kernel.org with ESMTP
	id S262477AbVEMSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:38:07 -0400
Subject: Re: Hyper-Threading Vulnerability
From: "Richard F. Rebel" <rrebel@whenu.com>
To: Andi Kleen <ak@muc.de>
Cc: Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <m164xnatpt.fsf@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aIwwNgspopsjZyOKqsAK"
Organization: Whenu.com
Date: Fri, 13 May 2005 14:38:03 -0400
Message-Id: <1116009483.4689.803.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.1.101mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aIwwNgspopsjZyOKqsAK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-05-13 at 20:03 +0200, Andi Kleen wrote:
> This is not a kernel problem, but a user space problem. The fix=20
> is to change the user space crypto code to need the same number of cache =
line
> accesses on all keys.=20
>=20
> Disabling HT for this would the totally wrong approach, like throwing
> out the baby with the bath water.
>=20
> -Andi

Why?  It's certainly reasonable to disable it for the time being and
even prudent to do so.

--=20
Richard F. Rebel

cat /dev/null > `tty`

--=-aIwwNgspopsjZyOKqsAK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBChPQLx1ZaISfnBu0RApFDAJ463Y8gyul28akGqpcbIDv9bD2RiwCePGM4
tz2YQjNnUlrtZ0LKT00eEnE=
=NJs5
-----END PGP SIGNATURE-----

--=-aIwwNgspopsjZyOKqsAK--

