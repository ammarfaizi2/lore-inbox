Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262811AbTDAToX>; Tue, 1 Apr 2003 14:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTDAToX>; Tue, 1 Apr 2003 14:44:23 -0500
Received: from B583e.pppool.de ([213.7.88.62]:47264 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262811AbTDAToW>; Tue, 1 Apr 2003 14:44:22 -0500
Subject: Re: flash as hda causes 2.4.18 to hang in
	grok_partitions()...add_to_page_cache_unique()
From: Daniel Egger <degger@fhm.edu>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: David Wuertele <dave-gnus@bfnet.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401184348.GB3736@arthur.home>
References: <m3smt3xuo1.fsf@bfnet.com> <1049212755.7628.5.camel@localhost>
	 <20030401184348.GB3736@arthur.home>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wSY/j0vbZkFJOgXQP3O2"
Organization: 
Message-Id: <1049226944.11985.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 21:55:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wSY/j0vbZkFJOgXQP3O2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2003-04-01 um 20.43 schrieb Erik Mouw:

> It usually is a CF bug. I've seen failing CF cards on one machine which
> work perfectly well in another machine. Just try the same card in
> another machine, or a get a new card. I haven't tried it with the new
> IDE code, though.

Well, I've seen CF cards not working in LBA mode, so changing that might
work. However the failures are of a completely different nature; read
errors seem to magically appear while here the detection is crashing.

--=20
Servus,
       Daniel

--=-wSY/j0vbZkFJOgXQP3O2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ie7Achlzsq9KoIYRArGhAKCBKJcjQZditzsa9VAARwKAjxxrdQCg1IMC
MeYD63e1bVAJMbyaDpCJVYQ=
=zSJ5
-----END PGP SIGNATURE-----

--=-wSY/j0vbZkFJOgXQP3O2--

