Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUAESOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUAESOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:14:38 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:55220 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265271AbUAESOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:14:36 -0500
Subject: Re: 2.6.1-rc1 affected?
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
References: <1073320318.21198.2.camel@midux>
	 <Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+Coaoa5l5hjmIBw9iYr+"
Message-Id: <1073326471.21338.21.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 20:14:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Coaoa5l5hjmIBw9iYr+
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 18:46, Linus Torvalds wrote:
> Yup.
>=20
Why isn't there any security update to 2.6.0/2.6.1-rc1 out yet, then?
Yes, the patch..
But I think there's corporations who use 2.6.0 and don't read the lkml.

Just a penny for my thoughts..

Regards,
Markus

> I'd actually personally prefer a stronger test than the one in 2.4.24, an=
d=20
> my personal preference would be for just disallowing the degenerate cases
> entirely.  I don't see a "mremap away" as being a valid thing to do, sinc=
e=20
> if that is what you want, why not just do a "munmap()"?
>=20
> Uli cc'd, to check whether libc could ever use a zero-sized mremap()..
>=20
> 		Linus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-+Coaoa5l5hjmIBw9iYr+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+amH3+NhIWS1JHARAkiZAJ4jbb5Wazhc+jyO5Pu/pWo0N923NwCfaYAh
36iGXFQHJ+3J455oNl5U1Mk=
=CGcJ
-----END PGP SIGNATURE-----

--=-+Coaoa5l5hjmIBw9iYr+--

