Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319479AbSIGMwW>; Sat, 7 Sep 2002 08:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319481AbSIGMwW>; Sat, 7 Sep 2002 08:52:22 -0400
Received: from B51f2.pppool.de ([213.7.81.242]:45763 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S319479AbSIGMwU>; Sat, 7 Sep 2002 08:52:20 -0400
Subject: Re: ide drive dying?
From: Daniel Egger <degger@fhm.edu>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: jbradford@dial.pipex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200209062122.31597.devilkin-lkml@blindguardian.org>
References: <200209061722.g86HMuPp004452@darkstar.example.net> 
	<200209062122.31597.devilkin-lkml@blindguardian.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-HU75I6U22o/tcxDlSFv5"
X-Mailer: Ximian Evolution 1.0.7 
Date: 07 Sep 2002 14:31:23 +0200
Message-Id: <1031401883.12089.41.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HU75I6U22o/tcxDlSFv5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2002-09-06 um 21.22 schrieb DevilKin:

> Well, there were 21 ATA errors, and it showed 5 error blocks, with disk '=
live'=20
> times of 629 hours.

No wonder it ran for 2 years. Are you using this machine frequently at
all? :)
=20
> The tests showed bad sectors, i'm currently running a disk erase.

This is exactly the mistake I've been meaning to warn you of.
The disk will corrupt sooner or later again and you'll have to go
through all the torture (possible backup/restore, missing data) again
and if you're unlucky (which is quite possible with your frequency of
use) the warranty is void until the problems appear the next time.

--=20
Servus,
       Daniel

--=-HU75I6U22o/tcxDlSFv5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9efGbchlzsq9KoIYRAp16AJ9Vo0L1/FbcdUU/DM0ffZ5bFCasSgCePbR0
YT2swo4flD1qZCspTT+iicA=
=rqnV
-----END PGP SIGNATURE-----

--=-HU75I6U22o/tcxDlSFv5--

