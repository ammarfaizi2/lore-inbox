Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUIXKub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUIXKub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUIXKua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:50:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23259 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268677AbUIXKu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:50:26 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Michal Rokos <michal@rokos.info>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4153EED2.1050508@yahoo.com.au>
References: <20040924014643.484470b1.akpm@osdl.org>
	 <4153EED2.1050508@yahoo.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b6GeQeazELWNKsrShf0O"
Organization: Red Hat UK
Message-Id: <1096022964.2612.42.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 12:49:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b6GeQeazELWNKsrShf0O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 at 11:54, Nick Piggin wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2=
/2.6.9-rc2-mm3/
> >=20
>=20
> > +natsemi-remove-compilation-warnings.patch
> >=20
> >  natsemi.c warning fixes
> >=20
>=20
> My card fails to work unless this change is backed out.
> -

which is not surprising.. turning mmio into io access without
significantly changing the driver otherwise does not improve chances of
working ;)


--=-b6GeQeazELWNKsrShf0O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBU/u0xULwo51rQBIRAjFUAJ9VdCh7mZHT1k2RlHIf+EV2opqyhACgj1GH
6MZWwluxFttmS/jhz8WnW9M=
=1l4h
-----END PGP SIGNATURE-----

--=-b6GeQeazELWNKsrShf0O--

