Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUCJNY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUCJNY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:24:56 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:21205 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262602AbUCJNYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:24:53 -0500
Date: Wed, 10 Mar 2004 14:22:52 +0100
To: linux-kernel@vger.kernel.org
Subject: hp smart arrray 5i and kernel 2.6.X
Message-ID: <20040310132252.GD28410@puettmann.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1B13fg-00028u-00*jHM6zS6vetc* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



        hello,

I have here a bunch of new HP DL380G3. Konfiguration:

System: Debian Sarge
Kernel : 2.6.2 2.6.3 2.6.4-rc2 and so on.
Hardware: HP DL380G3=20
Raid Controller: 5i with newest firmware caue teh old one has an bug on
                 hotplugging.


Problem:

The server is configured with 2 ( each 36 GB ) harddisks RAID1 for
system and 4 harddisks ( each 72 GB) RAID10 for data.=20

After installation the system and installing 2.6 I try to format the
RAID10 array it doesn't matter if ext2 or ext3. After the message:

Writing superblocks and filesystem accounting information:=20

the system freezed complete. No error message nothing. No disk aktivity


                Ruben




--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATxargHHssbUmOEIRAod2AJ9ggwnaAD4/Y/cyb6OP9MXm7fGnbQCeNZ64
LaTq8RjXQRZdYfrZ4/HIU5M=
=mkMo
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
