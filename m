Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbTDATAj>; Tue, 1 Apr 2003 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbTDATAj>; Tue, 1 Apr 2003 14:00:39 -0500
Received: from B583e.pppool.de ([213.7.88.62]:17311 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262778AbTDATAh>; Tue, 1 Apr 2003 14:00:37 -0500
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
From: Daniel Egger <degger@fhm.edu>
To: Christoph Rohland <cr@sap.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <ovn0jakwy7.fsf@sap.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE982@mailse01.se.axis.com>
	 <ovn0jakwy7.fsf@sap.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z3UmOoI+d7Y+pyZesa47"
Organization: 
Message-Id: <1049221575.7628.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 20:26:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z3UmOoI+d7Y+pyZesa47
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2003-04-01 um 18.24 schrieb Christoph Rohland:

> But on these systems you better use ramfs.

Just curious: Why? I'm using tmpfs on these systems and I'm rather
satisfied with it; especially the option to limit the amount of space
makes it rather useful. According to the documentation ramfs is most
useful as an educational example how to write filesystems not as a=20
real filesystem...

--=20
Servus,
       Daniel

--=-Z3UmOoI+d7Y+pyZesa47
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+idnHchlzsq9KoIYRAsglAKC4Q29ylhEjcgYWIpfYTgfNWUuUAQCeJjeH
nFtTTpRMjgpG5TM9bhlsIMA=
=1FmF
-----END PGP SIGNATURE-----

--=-Z3UmOoI+d7Y+pyZesa47--

