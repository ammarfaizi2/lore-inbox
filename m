Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264455AbTCXWJW>; Mon, 24 Mar 2003 17:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbTCXWJW>; Mon, 24 Mar 2003 17:09:22 -0500
Received: from 24-216-225-11.charter.com ([24.216.225.11]:28036 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S264455AbTCXWJT>;
	Mon, 24 Mar 2003 17:09:19 -0500
Date: Mon, 24 Mar 2003 17:20:27 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: SNARE and Ptrace?
Message-ID: <20030324222027.GD683@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Has anyone tested to see if "Snare" from intersectalliance.com can
detect someone executing a ptrace attack?  An old company I used to work
for has a number of production kernels out and can't just upgrade them
all over night so they need a good detection method and short-term fix
if possible.  In the past we had evaluated Snare which I pointed him to
but we're not sure if/how it might detect such an attack.

Thoughts/Theories?
  Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+f4Sr8+1vMONE2jsRArBvAKC/AdKs8eMRb9v/ZYskT3/IMl2hOwCfcbRS
nJroFZXXEq5oMr3xI6Cau+w=
=g7G2
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
