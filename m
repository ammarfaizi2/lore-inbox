Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbREEFpR>; Sat, 5 May 2001 01:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132822AbREEFpI>; Sat, 5 May 2001 01:45:08 -0400
Received: from ndslppp45.ptld.uswest.net ([63.224.227.45]:33583 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S132698AbREEFos>;
	Sat, 5 May 2001 01:44:48 -0400
Date: Fri, 4 May 2001 22:45:53 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Aaron Tiensivu <mojomofo@mojomofo.com>, linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Message-ID: <20010504224553.C15660@debian.org>
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu> <006e01c0d4e9$3c0bd210$0300a8c0@methusela> <20010504172657.B14969@debian.org> <20010505155113.D29451@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010505155113.D29451@metastasis.f00f.org>; from cw@f00f.org on Sat, May 05, 2001 at 03:51:13PM +1200
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2001 at 03:51:13PM +1200, Chris Wedgwood wrote:
>     I don't see how they figure, but in case there was any doubt I
>     have a VIA KT133A/686B board (Abit KT7A) and don't experience
>     anything resembling disk corruption unless the box crashes for
>     some other reason.  I do seem to be experiencing AGP problems in
>     spades, but my disks at least are fine.
>=20
> I too seem no disk problems whatsoever (nothing really interesting
> there, many people do not) but am also seeing AGP problems.
>=20
> In fact, I had to disable AGP to stop X locking the box hard... yet
> agpgart and the video driver (NVidia[1]) both claim to support the
> chipset -- does anyone actually have this working?)

Not an option with the Radeon unfortunately.  At least, not yet.  Whenever
I find the solution (recently a bunch of people have suggested a bunch of
things to try on dri-devel - thanks guys!) I'll post to that list what
fixed it since I know I am not the only person seeing this kind of
problem.  I think some of the guys are looking into improving the docs a
bit, so maybe if I find it soon the problem and workaround will get
documented.  =3D)

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

<hop> kb: I demand integrity and honesty in those who i do business with
<hop> i know my demands are unreasonable, but a guy can dream, can't he?


--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjrzk5EACgkQj/fXo9z52rNGKACfUQFVOg8hNChHTlCczvs9mmHA
B9cAoLCfshDKybHd3FwH940UVRrxRxLt
=RAGu
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
