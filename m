Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSJOSvU>; Tue, 15 Oct 2002 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbSJOSvU>; Tue, 15 Oct 2002 14:51:20 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:45550 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263291AbSJOSvS>; Tue, 15 Oct 2002 14:51:18 -0400
Subject: Re: What kernels 2.4.x 2.5.x compile gcc3.2???
From: Arjan van de Ven <arjanv@redhat.com>
To: clemens@dwf.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210151849.g9FInbur002088@orion.dwf.com>
References: <200210151849.g9FInbur002088@orion.dwf.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ce43AdBo2V5/FeNKq8eL"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Oct 2002 20:57:36 +0200
Message-Id: <1034708268.3408.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ce43AdBo2V5/FeNKq8eL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-15 at 20:49, clemens@dwf.com wrote:
> The subject just about says it.
> What versions of 2.4.x and 2.5.x compile cleanly with
> the new gcc 3.2 that is included in most recent releases
> (in particular RH8.0)
>=20
> The 2.4.18-14 kernel sources from RH have LOTS of patches,
> and they (well the modules) still dont compile with their
> own config file (sigh).

they do if you remember to use make mrproper when you switch from smp to
up or back...


--=-ce43AdBo2V5/FeNKq8eL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9rGUgxULwo51rQBIRAltJAJ9Ne108QJU1LTvblMF1IF61lFXnFQCdFPdV
hQtjxqCZZBUbZtbzHgsDjrI=
=hLcf
-----END PGP SIGNATURE-----

--=-ce43AdBo2V5/FeNKq8eL--

