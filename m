Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSLVS2u>; Sun, 22 Dec 2002 13:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSLVS2u>; Sun, 22 Dec 2002 13:28:50 -0500
Received: from iucha.net ([209.98.146.184]:60754 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S264683AbSLVS2t>;
	Sun, 22 Dec 2002 13:28:49 -0500
Date: Sun, 22 Dec 2002 12:36:57 -0600
From: Florin Iucha <florin@iucha.net>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Next round of AGPGART fixes.
Message-ID: <20021222183657.GA1043@iucha.net>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021220124137.GA28068@suse.de> <20021222155211.GB650@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20021222155211.GB650@iucha.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2002 at 09:52:11AM -0600, Florin Iucha wrote:
> On Fri, Dec 20, 2002 at 12:41:37PM +0000, Dave Jones wrote:
> > Linus,
> >  Please pull from bk://linux-dj.bkbits.net/agpgart to get at the
> > following fixes..
> [snip]
> > GNU diff for those who care (against Linus' bk tree) is at
> > ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.52/agpgart=
-fixes-1.diff
>=20
> I'm using bk7 which contains all your patch except via* stuff which I'm
> not interested in.
> Agpgart and sis-agp compiled as modules. Modprobe agpgart succeeds,=20
> modprobe sis-agp oopses:
>=20
> agpgart: Detected SiS 735 chipset

[snip oops]

With agpgart and sis-agp built in the kernel (non-modular) it works
fine - I have direct rendering enabled in X.

Cheers,
florin
--=20

"If it's not broken, let's fix it till it is."

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+BgZJNLPgdTuQ3+QRAuevAJ9cYC8nytYg3L1Wh4FDaT73y4N3CwCeLcRe
uOc5BsyrcRViiKNpMOvT2zQ=
=Fobt
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
