Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbRBIJjo>; Fri, 9 Feb 2001 04:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBIJjd>; Fri, 9 Feb 2001 04:39:33 -0500
Received: from TK212017114173.teleweb.at ([212.17.114.173]:57352 "HELO
	tk212017114173.teleweb.at") by vger.kernel.org with SMTP
	id <S129109AbRBIJjX>; Fri, 9 Feb 2001 04:39:23 -0500
Date: Fri, 9 Feb 2001 10:39:20 +0100
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010209103920.A19496@hostmaster.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <3A7AEFBF.2FBA5822@namesys.com> <200102021825.f12IPCu20705@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102021825.f12IPCu20705@devserv.devel.redhat.com>; from alan@redhat.com on Fri, Feb 02, 2001 at 01:25:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Since egcs-1.1.2 and gcc 2.95 miscompile the kernel strstr code dont forg=
et
> to stop those being used as well. Oh look you'll need CVS gcc to build the
> kernel... ah but wait that misbuilds DAC960.c...
How did you come to the conclusion that egcs-1.1.2 miscompiles the kernel?
I am using gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) for=
 a
while now and did not notice anything weird.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQEVAgUBOoO6x2D1OYqW/8uJAQE/nAgAgN6Odf2ZAkCcL+vODAX0Hud1S09rPSyP
wMyBIRpcSJNQuZNv3Rj67i6nPziJqiPeVtwsxbTY2LyWDVzmH0fah+dtLGCSccq7
g5UunMAhgJwBHhcohCHvYm9Z8lMOQ65vn0PG5hJNbAh2NXiIU4wJNpC2nl8PmJM6
2MEzQ8XwVe4EYodJvtBp9qlmaAY47dt86hefsDMh87Y0rCXBE1FLCmOWgeDDifpj
Ou5WfNMeNkuPkKUdK8QnJGmdCJ7inFnq/90ScuOwI6fvXMT0dQKkZh75c9qwrKi5
AGtR1PNB2F3aKOt2oZ/DHl+ID1U3IHeu08ZBnBP1cg/Yk5FaNwOZdQ==
=F2fh
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
