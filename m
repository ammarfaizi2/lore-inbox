Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272688AbTHPXUO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272917AbTHPXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:20:14 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:42947 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S272688AbTHPXUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:20:09 -0400
Subject: [2.6.0-test3-current] drivers/pnp/core.c:72: error: structure has
	no member named `name'
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <ramon.rey@hispalinux.es>
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BMG5eQC1gh/b/z7YzXU0"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1061076005.1304.34.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 17 Aug 2003 01:20:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BMG5eQC1gh/b/z7YzXU0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

It seems the struct dev.name was removed from include/linux/device.h and
should be implemented for every susbsystem.=20
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

--=-BMG5eQC1gh/b/z7YzXU0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/PrwkRGk68b69cdURAnojAJwOOOGIkFLxgVv2zPgM+F6SzRInAQCeO9qY
z/XsS2UfmdGN9AwUCrfq4Pk=
=3NAH
-----END PGP SIGNATURE-----

--=-BMG5eQC1gh/b/z7YzXU0--

