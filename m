Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265809AbTBTXfu>; Thu, 20 Feb 2003 18:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBTXfu>; Thu, 20 Feb 2003 18:35:50 -0500
Received: from B53d0.pppool.de ([213.7.83.208]:45735 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265809AbTBTXft>; Thu, 20 Feb 2003 18:35:49 -0500
Subject: Re: [Patch] Enable SSE for AMD Athlon (Thoroughbred) in 2.4.20
From: Daniel Egger <degger@fhm.edu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030220184525.GA23768@codemonkey.org.uk>
References: <1045266292.12105.41.camel@sonja>
	 <20030220184525.GA23768@codemonkey.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YyKjnEwObPyhtfO9I8W6"
Organization: 
Message-Id: <1045772262.5732.4.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 21:17:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YyKjnEwObPyhtfO9I8W6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2003-02-20 um 19.45 schrieb Dave Jones:

>  > A similar change for the just released Barton would also be nice but
>  > I do not have the model number handy.

> It's model 10. Somehow they skipped model 9.

> if (c->x86_model >=3D 6 && c->x86_model <=3D 10) {

> should do the right thing on all current models with SSE afaics..

I think so, too. The specific checks where just to be on the sure side....

--=20
Servus,
       Daniel

--=-YyKjnEwObPyhtfO9I8W6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+VTfmchlzsq9KoIYRAr6PAJ48SWh9VYPE0oTyG/87PWbG44ydpgCdEkCt
y6RNTaR+/IAMddjoHmzhHeo=
=QDZy
-----END PGP SIGNATURE-----

--=-YyKjnEwObPyhtfO9I8W6--

