Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVELRnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVELRnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVELRnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 13:43:03 -0400
Received: from gwyn.tux.org ([199.184.165.135]:3800 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id S262087AbVELRm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 13:42:59 -0400
Date: Thu, 12 May 2005 13:42:58 -0400
From: Timothy Ball <timball@tux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: remote keyboard
Message-ID: <20050512174258.GD29452@gwyn.tux.org>
References: <Pine.LNX.4.60.0505121017090.31256@lantana.cs.iitm.ernet.in> <20050512081240.GS8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20050512081240.GS8176@lug-owl.de>
User-Agent: Mutt/1.5.6i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gwyn.tux.org [0.0.0.0]); Thu, 12 May 2005 13:42:59 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2005 at 10:12:40AM +0200, Jan-Benedict Glaw wrote:
> On Thu, 2005-05-12 10:21:31 +0530, P.Manohar <pmanohar@lantana.cs.iitm.er=
net.in> wrote:
> > Instead of using the local keyboard input, I want sent the keyboard keys
> > from the remote system (another PC via Ethernet) and use it as if it=20
> > from
> >  the local keyboard.
>=20
> Write a small server which pushed pack input via uinput into the remote
> kernel.
>=20
> MfG, JBG
>=20

If you're using X you can use this:=20
	http://synergy2.sourceforge.net/
works quite well cross platform.

--timball

--=20
	GPG key available on pgpkeys.mit.edu
pub  1024D/511FBD54 2001-07-23 Timothy Lu Hu Ball <timball@tux.org>
Key fingerprint =3D B579 29B0 F6C8 C7AA 3840  E053 FE02 BB97 511F BD54

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCg5Wh/gK7l1EfvVQRAsZlAJ42cfHo/tnoXTTCC9+U6m+IOi/agQCfSg+z
FBg8YNBeczxeBX/zoCnsI+4=
=B3Jq
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
