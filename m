Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143384AbREKUEh>; Fri, 11 May 2001 16:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143380AbREKUCj>; Fri, 11 May 2001 16:02:39 -0400
Received: from ndslppp45.ptld.uswest.net ([63.224.227.45]:4677 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S143378AbREKUBw>;
	Fri, 11 May 2001 16:01:52 -0400
Date: Fri, 11 May 2001 13:02:03 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.4ac7 oops, locks in init on boot
Message-ID: <20010511130202.A8660@debian.org>
In-Reply-To: <20010511140019.A1248@debian-home.lcisp.com> <E14yIBC-0001XM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14yIBC-0001XM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 08:02:22PM +0100
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2001 at 08:02:22PM +0100, Alan Cox wrote:
> > If anyone has any further suggestions/patches to run 2.4.x with K7
> > chosen optimizations, I'm open to testing.
>=20
> 'Buy an AMD chipset box..'
>=20
> Seriously at this point I am out of ideas. The prefetch to far effect=20
> explained the old athlon locks (step 1) people reported on all chipsets. =
It
> didnt really seem to explain the problem with a few via chipset boards bu=
t I
> was hopeful.=20

I'm considering it, but for AGP weirdness reasons.  Have the USB bugs been
worked out?  I am highly dependant on USB.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

<Palisade> how are we going to pronounce '00 or '01 or '02 and so on?
<Deek> Say goodbye to the nineties, say hello to the naughties. :)


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjr8RToACgkQj/fXo9z52rNfGgCgskLfGS9V8dmbT243JZztjGLq
ux8An3bOoOPoyOE1KFov6YT08UfPTP0w
=9OtQ
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
