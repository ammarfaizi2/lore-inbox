Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDMMi0>; Fri, 13 Apr 2001 08:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRDMMiR>; Fri, 13 Apr 2001 08:38:17 -0400
Received: from cdsl18.ptld.uswest.net ([209.180.170.18]:49221 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S130038AbRDMMiD>;
	Fri, 13 Apr 2001 08:38:03 -0400
Date: Fri, 13 Apr 2001 05:38:09 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: natsemi.c (Netgear FA311 card) probmlems??
Message-ID: <20010413053809.E756@debian.org>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B59@mail0.myrio.com> <3AC22661.E69BE205@mandrakesoft.com> <20010411213236.P13920@altus.drgw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010411213236.P13920@altus.drgw.net>; from hozer@drgw.net on Wed, Apr 11, 2001 at 09:32:36PM -0500
X-Operating-System: Linux galen 2.4.3-ac4+lm+bttv
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2001 at 09:32:36PM -0500, Troy Benjegerdes wrote:
> > There are some improvements in the latest 2.4 test patch, 2.4.3-pre8.  I
> > would be very interested in hearing feedback on that.  I finally got two
> > test cards, FA311 and FA312, so I can work on it a bit too.
>=20
> Okay, I finally got around to testing this on 2.4.4-pre1. for the 5 or so=
=20
> minutes I've been using it so far, it seems okay (I'm able to log in this=
=20
> time), and I'm running NetPIPE to check performance.
>=20
> Perfomance isn't great (the peak bandwidth is 65 Mbps or so), but this
> could be partially due to my switch or the other machine I'm testing it
> with.

No, performance really is peaked about 65 Mbps or so at the moment.  I'm
currently using the FA312 here, which was massively broken with my FA312
until 2.4.2-ac which updated the natsemi driver.  I have a '311 in a P200
which worked fine before.  This is an AMD box, but I suspect the problem
was the '312, not the AMD.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

"This is the element_data structure for elements whose *element_type =3D
FORM_TYPE_SELECT_ONE, FORM_TYPE_SELECT_MULT. */ /* * nesting deeper
and deeper, harder and harder, go, go, oh, OH, OHHHHH!! * Sorry, got
carried away there. */ struct lo_FormElementOptionData_struct."
        -- Mozilla source code


--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjrW8zEACgkQj/fXo9z52rPurgCfYlWMuAw6UOg3MMIGJ+Lp8F4Q
+QMAnjSlZKDJQPcRDBhLoISSphnAy9NQ
=Oidv
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
