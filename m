Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264088AbRFNVxc>; Thu, 14 Jun 2001 17:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264097AbRFNVxW>; Thu, 14 Jun 2001 17:53:22 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:53515
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S264088AbRFNVxN>; Thu, 14 Jun 2001 17:53:13 -0400
Date: Thu, 14 Jun 2001 14:52:21 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Riley Williams <rhw@MemAlpha.CX>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Gigabit Intel NIC? - Intel Gigabit Ethernet Pro/1000T
Message-ID: <20010614145221.H17427@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Riley Williams <rhw@MemAlpha.CX>,
	Ion Badulescu <ionut@moisil.cs.columbia.edu>,
	Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106142155360.16844-100000@infradead.org> <E15AegA-0005Pt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15AegA-0005Pt-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 10:29:26PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I know, jumping in at this late-stage is bad form... but if we're talking
about the Intel 82543GC Gigabit MAC, why doesn't someone just use the
FreeBSD if_wx.c driver as a starting point?

It took me a while to find, as they refer to it as the LIVENGOOD instead of
the 82543, but the PCI ProductID values seem to match...

Matt

On Thu, Jun 14, 2001 at 10:29:26PM +0100, Alan Cox wrote:
> > As I see it, if Shawn has permission to freely distribute the specs,
> > he can send a copy to Alan Cox for forwarding to the relevant driver
> > developers. However, if he has to sign an NDA to get them, they're
> > useless...
> >=20
> > Alan: Am I right in assuming this?
>=20
> It depends on the NDA. Lots of vendors NDA their docs because they give e=
nough
> info to cloen the hardware, or explain how to fab the chip, or include pe=
rsonal
> details of employees .. and a million other reasons. Many sensible, many =
quite
> daft.
>=20
> But in my experience you have a better chance of getting a straight answe=
r out
> of a politician than intels networking folks. Maybe they have reformed
>=20
> Alan
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KTIVz64nssGU+ykRAgBjAJ9fjEx29WoJZYTfVcud6JWNSWzSRwCffTh/
uUX+ZJn4/PokffEKm1G7ciE=
=VGDW
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
