Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265267AbSJXAHX>; Wed, 23 Oct 2002 20:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265271AbSJXAHX>; Wed, 23 Oct 2002 20:07:23 -0400
Received: from [24.84.51.71] ([24.84.51.71]:30141 "HELO
	cherenkov.orbis-terrarum.net") by vger.kernel.org with SMTP
	id <S265267AbSJXAHW>; Wed, 23 Oct 2002 20:07:22 -0400
Date: Wed, 23 Oct 2002 17:13:32 -0700
From: Robin Johnson <robbat2@orbis-terrarum.net>
To: linux-kernel@vger.kernel.org
Subject: SGI Visual Support?
Message-ID: <20021024001332.GA6151@cherenkov.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings list

I am writing to enquire of the status of SGI Visual Workstation support
in the 2.5 series.

The Linux VISWS page on sourceforge
http://sourceforge.net/projects/linux-visws
Has a patch for 2.5.24
This currently doesn't apply 2.5.44 due to the i386 arch split in
2.5.37.

It seems the patch on the site developed from this thread, but ends
inconclusively:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D102465834001728&w=3D2

Did anybody get it working more than this?
Does anybody have any more input about the VISWS code working/not
working?

I ask because I have a lot of VISWS 320 boxes at my disposal now and I
am interested in using them because of the really nice SCSI system they
have.  I've got one connected to a 20Gb DLT drive for doing backups
presently, running 2.2.10 (the only kernel I could get to work). But I
need a more recent kernal with netfilter for some firewalling issues.

Here was the patch for 2.4.17:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101009267028328&w=3D2

(please CC your replies to me, as I am not subscribed)=20

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQE9tzsssnuUTjSIToURAmlpAJwJjyK7NgT+wvy5QHHyz5827FELRwCfTokP
HaxB/vowdJCzY0O1Me+N4xE=
=46gR
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
