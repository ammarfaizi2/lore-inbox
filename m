Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWGTL31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWGTL31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 07:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWGTL31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 07:29:27 -0400
Received: from bach.cuivres.net ([82.225.0.213]:26792 "EHLO bach.cuivres.net")
	by vger.kernel.org with ESMTP id S1030266AbWGTL3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 07:29:25 -0400
Date: Thu, 20 Jul 2006 13:29:24 +0200
From: Ludovic RESLINGER <lr@cuivres.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS Raid on Apple PowerMac G5
Message-ID: <20060720112923.GD21541@bach>
Reply-To: Ludovic RESLINGER <lr@cuivres.net>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060720100313.GC21541@bach> <Pine.LNX.4.61.0607201255520.2633@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607201255520.2633@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2006 at 12:56:10PM +0200, Jan Engelhardt wrote:
> >
> >I would like to know if linux kernel manage XFS Raid on Apple PowerMac,
> >because it seem impossible to create a XFS RAID with Apple partition map=
=2E I've
> >tested with a linux-2.6.14 of uptream tree. My computer is a Apple Power=
Mac
> >G5. mac-fdisk refused to create XFS RAID, so I asked myself if linux-ker=
nel
> >can boot on an XFS RAID and Apple Partition Map.
>=20
> XFS-specific problem?
>=20
>=20
>=20
> Jan Engelhardt

Re,

I don't know if it is a XFS-specific problem, I might test with another
files system.
In fact, I think this is a problem of RAID with Apple Partition Map.

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

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEv2kT/IDTo7Ygh6kRAoXCAJ9/EcXWOl6F3Ojzip4cgWbfJgl85QCfawem
93npz8QN1Qh+EUszZqk3VE4=
=497z
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
