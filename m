Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273779AbRIXDf1>; Sun, 23 Sep 2001 23:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273781AbRIXDfS>; Sun, 23 Sep 2001 23:35:18 -0400
Received: from cs6625186-50.austin.rr.com ([66.25.186.50]:17792 "EHLO
	hatchling.taral.net") by vger.kernel.org with ESMTP
	id <S273779AbRIXDfF>; Sun, 23 Sep 2001 23:35:05 -0400
Date: Sun, 23 Sep 2001 22:35:31 -0500
From: Taral <taral@taral.net>
To: khromy <khromy@lnuxlab.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 problems with X + USB mouse
Message-ID: <20010923223531.A9228@taral.net>
In-Reply-To: <20010923222036.A1685@taral.net> <20010923233022.A30991@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20010923233022.A30991@lnuxlab.ath.cx>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2001 at 11:30:22PM -0400, khromy wrote:
> On Sun, Sep 23, 2001 at 10:20:36PM -0500, Taral wrote:
> > I have XFree86 4.1.0 and a USB mouse with input core support. On 2.4.9
> > everything is happy. On 2.4.10 the mouse clicks randomly and jumps to
> > the bottom left corner a lot. This doesn't affect gpm though, only X.
> >=20
> > Any ideas? I've backed down to 2.4.9 for now.
>=20
> I had this problem too.  I used NetMousePS/2 in XF86Config but changing
> it to IMPS/2 fixed it.
>=20
> 5 button Microsoft IntelliMouse?

A clone of, yes. I wonder what changed in 2.4.10 to break this?

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjuuqgMACgkQoQQF8xCPwJT09wCfYDVLYAbb2r+3q+stMdG1GH97
7IMAn1P0db17DJ415rKdRBkDbGJZMQaW
=jHCJ
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
