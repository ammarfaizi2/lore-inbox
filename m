Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbREVHUH>; Tue, 22 May 2001 03:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262356AbREVHTr>; Tue, 22 May 2001 03:19:47 -0400
Received: from lenka.ph.ipex.cz ([212.71.128.11]:13896 "EHLO lenka.ph.ipex.cz")
	by vger.kernel.org with ESMTP id <S261427AbREVHTh>;
	Tue, 22 May 2001 03:19:37 -0400
Date: Tue, 22 May 2001 09:20:46 +0200
From: Robert Vojta <vojta@ipex.cz>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c905C-TX [Fast Etherlink] problem ...
Message-ID: <20010522092046.C761@ipex.cz>
In-Reply-To: <20010521090946.D769@ipex.cz> <3B0963AF.FDCB8AA2@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <3B0963AF.FDCB8AA2@gmx.at>
User-Agent: Mutt/1.3.18i
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> I had the same problem with 2.4.3-pre6 (also with the 3c905C). Alle
> problems were gone with 2.4.4, so I stopped bothering. Hope this
> helps...

Hi,
  as I wrote in previous emails, I tried kernel 2.2.16, 2.2.19 and 2.4.x
series (means 2.4.1, 2.4.3, 2.4.4) and still this error. So, I must forced
my card to operate in full-duplex mode and errors gone.

Best,
  .R.V.

--=20
   _
  |-|  __      Robert Vojta <vojta-at-ipex.cz>          -=3D Oo.oO =3D-
  |=3D| [Ll]     IPEX, s.r.o.
  "^" =3D=3D=3D=3D`o

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsKE04ACgkQInNB3KDLeVNfcACdHN7zTTn5dyJXbduTSWRm9ROD
vw0AnA5EAcKSs/+CRBianyPnzYruCMGs
=kc0O
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
