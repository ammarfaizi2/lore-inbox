Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132315AbRA2P1L>; Mon, 29 Jan 2001 10:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRA2P1B>; Mon, 29 Jan 2001 10:27:01 -0500
Received: from sin.sloth.org ([207.0.237.38]:48132 "EHLO sin.sloth.org")
	by vger.kernel.org with ESMTP id <S132315AbRA2P0p>;
	Mon, 29 Jan 2001 10:26:45 -0500
Date: Mon, 29 Jan 2001 10:26:44 -0500
From: Geoffrey Gallaway <geoffeg@sloth.org>
To: linux-kernel@vger.kernel.org
Subject: Incorrect NFS_Config documentation
Message-ID: <20010129102644.A24448@sin.sloth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 2.4.0 kernel's config help for CONFIG_NFSD:
---
=2E....

In either case, you will need support software; the respective
locations are given in the file Documentation/Changes in the NFS
section.                                                               =20

=2E....
---

However, I see no NFS section in Documentation/Changes.

Geoff

--=20
Geoffrey Gallaway || The only certainty is that nothing is certain.
geoffeg@sloth.org ||
D e v o r z h u n || 				-- Fortune Cookie

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjp1i7QACgkQrAD4O1w1lqNSkQCfXUSEpCDF3y728Xr75HX0QGk8
6scAn0Mk0/Zuw5D8hR+W3ZGdsxPbFrd4
=17dG
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
