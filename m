Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbTHJPHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTHJPHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 11:07:23 -0400
Received: from mx1.apa.co.im ([195.10.116.2]:17176 "HELO vs2.manx.net")
	by vger.kernel.org with SMTP id S269646AbTHJPHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 11:07:21 -0400
Subject: SMBFS & >=test2
From: John Mylchreest <johnm@gentoo.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-urSxF/Wnn56QqeAf+Y94"
Message-Id: <1060528037.4470.6.camel@johnm.willow.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 16:07:17 +0100
X-OriginalArrivalTime: 10 Aug 2003 15:08:46.0986 (UTC) FILETIME=[4C13C6A0:01C35F51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-urSxF/Wnn56QqeAf+Y94
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Since test2 I have suffered a problem with smbfs mounts using autofs.
Below is the error I get whenever i try and access the mount via the
mount location for autofs.

>>> smb_add_request: request [e2de1ec0, mid=3D127] timed out!
I sometimes also recieve this:
>>> smb_lookup: find //Audio failed, error=3D-5

I also get the same error when mounting manually.
I am using samba3 b3.

Any help would be appreciated

--=20

John Mylchreest.

Gentoo Linux:	 http://www.gentoo.org
Public Key:	 gpg --recv-keys 0xEAB9E721
		 http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xEAB9E721

Key fingerprint: 0670 E5E4 F461 806B 860A  2245 A40E 72EB EAB9 E721

--=-urSxF/Wnn56QqeAf+Y94
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Nl+lpA5y6+q55yERAqnbAJ9+6f6Tgw7eUKkEyutKYoOun2WXJwCgoF77
/dCRpu06JUEZqNrDmRZMBiE=
=uGP/
-----END PGP SIGNATURE-----

--=-urSxF/Wnn56QqeAf+Y94--

