Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUHARci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUHARci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUHARcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:32:36 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:11941 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S266073AbUHARb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:31:57 -0400
Date: Sun, 1 Aug 2004 19:31:52 +0200
From: Harald Welte <laforge@netfilter.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: James Morris <jmorris@intercode.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [2.6 patch] netfilter/ip_nat_snmp_basic.c: fix inlines (fwd)
Message-ID: <20040801173152.GG14539@sunbeam2>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	James Morris <jmorris@intercode.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.netfilter.org
References: <20040729212048.GD23589@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20040729212048.GD23589@fs.tum.de>
User-Agent: Mutt/1.5.6+20040523i
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2004 at 11:20:49PM +0200, Adrian Bunk wrote:
>=20
> FYI:
> The patch forwarded below is still required in 2.6.8-rc2-mm1.

I've pushed your patch to DaveM now.  Apparently some gcc-3.4 specific
issue...

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBDSkIXaXGVTD0i/8RAsD8AJ4txHIHfG1T6pLzJ2iCaqwxvZ3avQCeNN5y
L3IoXydcPIb8H0N9IxwcIO8=
=plPE
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
