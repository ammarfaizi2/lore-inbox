Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSLYAFt>; Tue, 24 Dec 2002 19:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSLYAFt>; Tue, 24 Dec 2002 19:05:49 -0500
Received: from dialin-145-254-148-203.arcor-ip.net ([145.254.148.203]:52610
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S265791AbSLYAFs>; Tue, 24 Dec 2002 19:05:48 -0500
Date: Wed, 25 Dec 2002 00:12:26 +0000
From: Nico Schottelius <schottelius@wdt.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4 series: IDE driver
Message-ID: <20021225001226.GA21252@schottelius.org>
References: <20021223135846.GA1988@schottelius.org> <20021224235054.GA721@gallifrey>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20021224235054.GA721@gallifrey>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Dr. David Alan Gilbert [Tue, Dec 24, 2002 at 11:50:54PM +0000]:
> * Nico Schottelius (schottelius@wdt.de) wrote:
>=20
> > If I change the notebook it runs fine.
> > If I change the harddisks it works fine.
> > If I use 2.5 series kernels it works fine.
>=20
> > ALI15X3: IDE controller at PCI slot 00:10.0
> > ALI15X3: chipset revision 195
> > ALI15X3: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio
>=20
> I have heard it said that DMA on the ALI chipset is a bit touchy (not
> sure if driver or hardware) - it is worth trying with the DMA off.

dma works fine on all other constellations, but I will try it without
dma as soon as 2.4.20 is compiled...

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+CPfqtnlUggLJsX0RApUSAJ0Ysllc57MGNUr7AjjgffIbEUw2oQCeKcyi
WIMT0CIKMaOqc6FBUE5qdYM=
=sRsb
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
