Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264031AbTCUWdQ>; Fri, 21 Mar 2003 17:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264006AbTCUWcU>; Fri, 21 Mar 2003 17:32:20 -0500
Received: from B543a.pppool.de ([213.7.84.58]:13490 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S264007AbTCUWaq>; Fri, 21 Mar 2003 17:30:46 -0500
Subject: Re: 2.5 AGP no good (VIA KT333, radeon 7500)
From: Daniel Egger <degger@fhm.edu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Duncan Sands <baldrick@wanadoo.fr>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030321153820.GB3762@suse.de>
References: <200303211615.28675.baldrick@wanadoo.fr>
	 <20030321153820.GB3762@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-igh+zPgMWpJ/KM8p68hl"
Organization: 
Message-Id: <1048284391.15175.28.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Mar 2003 23:06:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-igh+zPgMWpJ/KM8p68hl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-03-21 um 16.38 schrieb Dave Jones:

> Strange, and this only happens when you have agpgart loaded ?

I believe I sent a similar mail to the list a week or so ago.
I'm experiencing troubles with KT400 when built as a module
and compiled in. The exact troubles depend on the kernel version.
2.6.54 will fire up but hang as soon as I fire up any GL application.
2.6.55 will eat endless amounts of memory when loading the module
thereby bringing the machine to crawl.

--=20
Servus,
       Daniel

--=-igh+zPgMWpJ/KM8p68hl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+e4znchlzsq9KoIYRAs4SAJ4h9bulKgWSYPCOpuklUacoB7ocOACffs41
jbZo/BXhxCuXB1uzlHPE2Ps=
=zqxk
-----END PGP SIGNATURE-----

--=-igh+zPgMWpJ/KM8p68hl--

