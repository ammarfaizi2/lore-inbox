Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRAaBQq>; Tue, 30 Jan 2001 20:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132786AbRAaBQg>; Tue, 30 Jan 2001 20:16:36 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:10737 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S132680AbRAaBQW>;
	Tue, 30 Jan 2001 20:16:22 -0500
Date: Tue, 30 Jan 2001 17:15:28 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: John Jasen <jjasen1@umbc.edu>
Cc: Matthew Gabeler-Lee <msg2@po.cwru.edu>, linux-kernel@vger.kernel.org,
        AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
Message-ID: <20010130171528.B25507@turbolinux.com>
In-Reply-To: <Pine.LNX.4.32.0101301830330.1138-100000@cheetah.STUDENT.cwru.edu> <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu>; from John Jasen on Tue, Jan 30, 2001 at 07:53:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have experienced similar issues with 2.4.0 and its test. I have a bttv848=
 chipset.
I even tried compiling in kdb as a part of the kernel to see if it oopses, =
but no luck.

I will try trying 0.7.47 today.

this works on 2.2.16, last time i tried.

--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | "You've got to think about tomorrow!"=20
of a GNU generation   -o)  | "TOMORROW!  I haven't even prepared for=20
Kernel 2.4.0-ac4      /\\  | yesterday* yet!"=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

On Tue, Jan 30, 2001 at 07:53:11PM -0500, John Jasen wrote:
> On Tue, 30 Jan 2001, Matthew Gabeler-Lee wrote:
>=20
> > These errors all occur in the same way (as near as I can tell) in
> > kernels 2.4.0 and 2.4.1, using bttv drivers 0.7.50 (incl. w/ kernel),
> > 0.7.53, and 0.7.55.
> >
> > I am currently using 2.4.0-test10 with bttv 0.7.47, which works fine.
> >
> > I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
> > been able to track down the bug yet.  I thought that by posting here,
> > more eyes might at least make more reports of similar situations that
> > might help track down the problem.
>=20
> Try flipping the card into a different slot. A lot of the cards
> exceptionally do not like IRQ/DMA sharing, and a lot of the motherboards
> share them between different slots.
>=20
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- In theory, theory and practise are the same. In practise, they aren't.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6d2cw5UrYeFg/7bURAjyJAJwM5ocdZr00Z3Z4fkTomZHHGFADTwCeLYkf
bX+V/izn4pXxP01sdBmKbg8=
=DHTP
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
