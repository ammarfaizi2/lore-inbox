Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUDYKt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUDYKt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 06:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUDYKt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 06:49:58 -0400
Received: from mx.laposte.net ([81.255.54.11]:18382 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261430AbUDYKty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 06:49:54 -0400
Subject: Re: Update on problems creating iteraid driver disk
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: fedora-devel-list@redhat.com
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <408B270C.1050201@gear.dyndns.org>
References: <408B270C.1050201@gear.dyndns.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3EbmLpPfBK9QRKJgE0CB"
Organization: Adresse personelle
Message-Id: <1082890181.24757.12.camel@m64.net81-64-154.noos.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 (1.5.7-2) 
Date: Sun, 25 Apr 2004 12:49:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3EbmLpPfBK9QRKJgE0CB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le dim, 25/04/2004 =C3=A0 12:48 +1000, Paul Gear a =C3=A9crit :
> Hi folks,
>=20
> A while back i posted about trying to create iteraid driver disks for
> FC1.  With the help of David Kewley's instructions
> (http://www.klab.caltech.edu/~kewley/driverdisk/dd.html) on using Doug
> Ledford's driver kit (http://people.redhat.com/dledford/), i managed to
> create a proper driver disk.

Frankly if you really want to bother with ite hardware (the SII680 is
available here for the same price and is perfectly supported under
Linux) you should focus on getting their driver inside the kernel.org
sources.

ie make diffs, submit them to LKM, make the changes people request, etc
(ite is GPLed if  I remember well).

This may seem more difficult but remember the kernel is a moving
target : after six months you'll have spent more energy getting this
out-of-tree driver work than getting it in-tree now.

Cheers,

--=20
Nicolas Mailhot

--=-3EbmLpPfBK9QRKJgE0CB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAi5fFI2bVKDsp8g0RAmKfAJ4iX2VybOQ4g/OKpmx3d2SKqiu9mgCgjK81
Mq6K2eTno5hDGasiMqODJa4=
=TFWx
-----END PGP SIGNATURE-----

--=-3EbmLpPfBK9QRKJgE0CB--

