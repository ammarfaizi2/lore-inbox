Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbTCGO3l>; Fri, 7 Mar 2003 09:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbTCGO3l>; Fri, 7 Mar 2003 09:29:41 -0500
Received: from B5036.pppool.de ([213.7.80.54]:60296 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261617AbTCGO3k>; Fri, 7 Mar 2003 09:29:40 -0500
Subject: Re: Kernel bloat 2.4 vs. 2.5
From: Daniel Egger <degger@fhm.edu>
To: Andreas Boman <aboman@midgaard.us>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1046993653.30701.3.camel@asgaard.midgaard.us>
References: <20030306142252.22630.qmail@linuxmail.org>
	 <1046980273.18897.30.camel@sonja>
	 <1046993653.30701.3.camel@asgaard.midgaard.us>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eMkDiZTKXO6VHidlMp9s"
Organization: 
Message-Id: <1047043988.25089.36.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 14:33:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eMkDiZTKXO6VHidlMp9s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-03-07 um 00.34 schrieb Andreas Boman:

> apt-get install module-init-tools, it will install 'right' and let you
> use modules with 2.4 and 2.5 kernels.

Close but not cigar. Trying to load modules blocks the system quite a
bit and I get lots of failures like realloc errors which unfortunately
disappear too fast from the screen to capture. The system is still
booting after 6 mins...

  257 root      15 -10  257m 227m 1176 D 80.8 45.1   0:22.67 modprobe

The system is fully saturated by modprobes... :(

--=20
Servus,
       Daniel

--=-eMkDiZTKXO6VHidlMp9s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+aJ+Uchlzsq9KoIYRApspAKCEHD6ERwFtR91/F3NDSDGs6l0gigCggheU
LU6qW1UKPDGu47WYi2fgNhk=
=JHwI
-----END PGP SIGNATURE-----

--=-eMkDiZTKXO6VHidlMp9s--

