Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266601AbSKLPeD>; Tue, 12 Nov 2002 10:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKLPcn>; Tue, 12 Nov 2002 10:32:43 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:21492 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S261683AbSKLPcH>;
	Tue, 12 Nov 2002 10:32:07 -0500
Subject: File Limit in Kernel?
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-gjU1b+qYiuNy2hSLpQYr"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 10:38:55 -0500
Message-Id: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 12 Nov 2002 15:38:57.0648 (UTC) FILETIME=[9D5E9F00:01C28A61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gjU1b+qYiuNy2hSLpQYr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have a directory with 39,000 files in it, and I'm trying to use the cp
command to copy them into another directory, and neither the cp or the
mv command will work, they both same "argument list too long" when I
use:

cp -f * /usr/local/www/images

or

mv -f * /usr/local/www/images

Is this a kernel limitation? If yes, how can I get around it?
If no, anyone know a workaround? I appreciate it.

--=20
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

--=-gjU1b+qYiuNy2hSLpQYr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA90SCPF9k9BmZXCWYRAqlsAJoCW1C/DfWSlwOiVQulcNLidr8RrACeIEph
MgAaBBF1vNaDnpS0rXfC/NI=
=Cd37
-----END PGP SIGNATURE-----

--=-gjU1b+qYiuNy2hSLpQYr--

