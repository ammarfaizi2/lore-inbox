Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319283AbSIFR1R>; Fri, 6 Sep 2002 13:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSIFR1R>; Fri, 6 Sep 2002 13:27:17 -0400
Received: from B5294.pppool.de ([213.7.82.148]:24254 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S319274AbSIFR1Q>; Fri, 6 Sep 2002 13:27:16 -0400
Subject: Re: ide drive dying?
From: Daniel Egger <degger@fhm.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031326689.9861.45.camel@irongate.swansea.linux.org.uk>
References: <200209061713.51387.devilkin-lkml@blindguardian.org> 
	<1031326689.9861.45.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-obfOzg4ODD0QEHqbhdwK"
X-Mailer: Ximian Evolution 1.0.7 
Date: 06 Sep 2002 19:33:23 +0200
Message-Id: <1031333604.11356.7.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-obfOzg4ODD0QEHqbhdwK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2002-09-06 um 17.38 schrieb Alan Cox:

> Get the IBM disk tools, upgrade the firmware and see what the ibm tools
> have to say. IBM drives have had some problems with spontaneous bad
> blocks appearing that go away with new firmware and a run of the disk
> tools.

The "run of the disk tools" that does away with the badblocks is a
lowlevel format; a tedious way to spent ones' time on a harddrive
that will die anyway soon.

> More importantly if thats the problem with the firmware update
> they dont come back until the drive really dies.

Right, which is probably shortly after. Especially on a two years
old drive I wouldn't go through all the troubles to backup 60GB
data, lowlevel format the drive, restore the data and hope the
problems are gone; instead I'd rather get a new drive within the
warranty and cross fingers.

BTW: I did the backup way exactly once and the drive got back to me
with new errors two weeks after.

--=20
Servus,
       Daniel

--=-obfOzg4ODD0QEHqbhdwK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9eObjchlzsq9KoIYRAp2MAJwKB2vsCxN8Uo4sHGjndrVRqqCGvQCdFO0p
tmsOiRQC4NCd8H606+P1RBE=
=yLzW
-----END PGP SIGNATURE-----

--=-obfOzg4ODD0QEHqbhdwK--

