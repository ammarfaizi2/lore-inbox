Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWCBUvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWCBUvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWCBUvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:51:12 -0500
Received: from lug-owl.de ([195.71.106.12]:31155 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932284AbWCBUvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:51:11 -0500
Date: Thu, 2 Mar 2006 21:51:06 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060302205105.GF19232@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <20060302195106.GC19232@lug-owl.de> <20060302203922.GE9295@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RjJ1HjOwPpAMVNtA"
Content-Disposition: inline
In-Reply-To: <20060302203922.GE9295@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RjJ1HjOwPpAMVNtA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-02 21:39:22 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Mar 02, 2006 at 08:51:06PM +0100, Jan-Benedict Glaw wrote:
> > On Thu, 2006-03-02 18:38:40 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > > On Thu, Mar 02, 2006 at 12:31:34PM +1100, Herbert Xu wrote:
> > > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > > It does also matter in the kernel image size case, since you have=
 to put=20
> > > > > enough modules to the other medium for having a effect bigger tha=
n the
> > > > > kernel image size increase from setting CONFIG_MODULES=3Dy.
> > > > That's not very difficult considering the large number of modules t=
hat's
> > > > out there that a system may wish to use.
> > > This might be true for full-blown desktop systems - but these do not=
=20
> > > tend to be the systems where kernel image size matters that much.
> > > Smaller kernel image size might be an issue e.g. for distribution=20
> > > kernels, but in a much less pressing way.
> > Kernel image size matters if you try to make it boot off a floppy.
>=20
> Sure, but the usual router-on-a-floppy cases are similar cases where=20
> CONFIG_MODULES=3Dn brings at least as much gain as making things modular.

You may want to have a chance to load modules from an initrd with is
on a 2nd floppy.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--RjJ1HjOwPpAMVNtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEB1q5Hb1edYOZ4bsRAvtSAJ9vsPdWRVBhears1Clh2/9cyBlXNgCfeGcv
atlCJKvOeDqn3rFaUrYgiNk=
=btET
-----END PGP SIGNATURE-----

--RjJ1HjOwPpAMVNtA--
