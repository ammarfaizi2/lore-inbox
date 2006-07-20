Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWGTT5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWGTT5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 15:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWGTT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 15:57:23 -0400
Received: from bach.cuivres.net ([82.225.0.213]:40873 "EHLO bach.cuivres.net")
	by vger.kernel.org with ESMTP id S1030369AbWGTT5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 15:57:22 -0400
Date: Thu, 20 Jul 2006 21:57:19 +0200
From: Ludovic RESLINGER <lr@cuivres.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS Raid on Apple PowerMac G5
Message-ID: <20060720195718.GF21541@bach>
Reply-To: Ludovic RESLINGER <lr@cuivres.net>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20060720100313.GC21541@bach> <Pine.LNX.4.61.0607201255520.2633@yvahk01.tjqt.qr> <20060720112923.GD21541@bach> <1153420317.16159.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <1153420317.16159.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2006 at 02:31:57PM -0400, Benjamin Herrenschmidt wrote:
>=20
> > I don't know if it is a XFS-specific problem, I might test with another
> > files system.
> > In fact, I think this is a problem of RAID with Apple Partition Map.
>=20
> I remember reading something about it a while ago... can't remember the
> details but I think it was possible. At worst, an option is to use a
> different partition map and boot the kernel from a USB stick :)
>=20
> Ben.
>=20
>
Re,

Thank you for your answer. I will make more tests to have more informations.
I thought to the solution by USB stick too :).

Cheers,
--=20
    .---.      Ludovic RESLINGER
   /     \
   \.@-@./     Trumpet Student in CNR
   /`\_/`\     Free Software Developer
  // )X( \\
 | \  :  )|_                   _,'|   .''`.
/`\_`>  <_/ \ @=3D=3D=3D=3D=3D=3DTTT=3D=3D=3D=3D=3D::_  |  : :'  :
\__/'---'\__/   ((_<=3DHHH___))   `.|  `. `'`
                 `---UUU---'=3D>         `-

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEv+Ae/IDTo7Ygh6kRAvhKAJ0fSmecdYdmVurdL5YWBEJ4UuD+MgCfdCHv
olJgMOIRy5dIade76YYfj54=
=dzdI
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
