Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbQKKPqv>; Sat, 11 Nov 2000 10:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbQKKPql>; Sat, 11 Nov 2000 10:46:41 -0500
Received: from airbus.mayn.de ([194.145.150.13]:9014 "HELO mayn.de")
	by vger.kernel.org with SMTP id <S131103AbQKKPqc>;
	Sat, 11 Nov 2000 10:46:32 -0500
Date: Sat, 11 Nov 2000 16:43:39 +0100
From: Thomas Köhler <jean-luc@picard.franken.de>
To: linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111164339.A28594@picard.franken.de>
Mail-Followup-To: Thomas Köhler <jean-luc@picard.franken.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A0C86B3.62DA04A2@best.com> <20001110234750.B28057@wire.cadcamlab.org> <20001111153036.A28928@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001111153036.A28928@gruyere.muc.suse.de>; from ak@suse.de on Sat, Nov 11, 2000 at 03:30:36PM +0100
X-Operating-System: Linux picard 2.2.17
X-Editor: VIM - Vi IMproved 6.0l ALPHA http://www.vim.org/
X-IRC: tirc; Nick: jeanluc
X-URL: http://jeanluc-picard.de/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2000 at 03:30:36PM +0100,
Andi Kleen <ak@suse.de> wrote:
>=20
> On Fri, Nov 10, 2000 at 11:47:50PM -0600, Peter Samuelson wrote:
> > 2b) If yes, write a perl script to compute symbol sizes from each
> >     System.map file.  (Symbol size =3D=3D address of next symbol minus
> >     address of this symbol.)  Sort numerically, then compare old vs new
> >     for symbols that have grown a lot, or large new symbols.
>=20
> No need to write one: ftp.firstfloor.org:/pub/ak/perl/bloat-o-meter

Would be good if you added a notice under which licence you put all
these nice perl scripts... Are they GPL'ed? Under a BSD-style licence?
Something else?

> -Andi

CU,
Thomas

--=20
 Thomas K=F6hler Email:   jean-luc@picard.franken.de     | LCARS - Linux
     <><        WWW:     http://jeanluc-picard.de      | for Computers
                IRC:             jeanluc               | on All Real
               PGP public key available from Homepage! | Starships

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6DWkrTEYXWMJlHuYRAqifAJ9v/qNyhF3DXQ663LVCpsKpsevQgQCffBcf
EHEonRyUT7UAkrPwXYkuxzI=
=fJaP
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
