Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKGSji>; Tue, 7 Nov 2000 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQKGSj2>; Tue, 7 Nov 2000 13:39:28 -0500
Received: from client38155.atl.mediaone.net ([24.88.38.155]:35577 "HELO
	whitestar.soark.net") by vger.kernel.org with SMTP
	id <S129111AbQKGSjO>; Tue, 7 Nov 2000 13:39:14 -0500
Date: Tue, 7 Nov 2000 13:39:04 -0500
From: "Zephaniah E. Hull" <warp@whitestar.soark.net>
To: Ragnar Hojland Espinosa <ragnar_hojland@eresmas.com>
Cc: Ragnar Hojland Espinosa <ragnar@jazzfree.com>,
        linux-kernel@vger.kernel.org, "M.H.VanLeeuwen" <vanl@megsinet.net>,
        "CRADOCK, Christopher" <cradockc@oup.co.uk>
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001107133904.A6082@whitestar.soark.net>
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk> <3A00B8E9.D5FD12B0@megsinet.net> <20001102185706.A984@macula.net> <20001102193856.A1204@macula.net> <20001103012510.A22193@whitestar.soark.net> <20001107112237.A876@macula.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001107112237.A876@macula.net>; from ragnar_hojland@eresmas.com on Tue, Nov 07, 2000 at 11:22:37AM +0100
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2000 at 11:22:37AM +0100, Ragnar Hojland Espinosa wrote:
<snip>
> > You have a voodoo3 or voodoo5 with X4, and the DRI X4 module loaded.
> >=20
> > Or am I wrong?
>=20
> v3.. bingo :)

Comment out the 'Load "dri"' line from /etc/X11/XF86Config-4, I'm
working on debugging the problems.

Zephaniah E. Hull.
>=20
> --=20
> ____/|  Ragnar H=F8jland     Freedom - Linux - OpenGL      Fingerprint  9=
4C4B
> \ o.O|                                                   2F0D27DE025BE230=
2C
>  =3D(_)=3D  "Thou shalt not follow the NULL pointer for      104B78C56 B7=
2F0822
>    U     chaos and madness await thee at its end."       hkp://keys.pgp.c=
om
>=20
> Handle via comment channels only.
>=20

--=20
 PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
    Keys available at http://whitestar.soark.net/~warp/public_keys.
           CCs of replies from mailing lists are encouraged.

I am an "expert".  Fear me, for I will wreak untold damage upon anything
I can get my grubby hands on.
  -- Matt McLeod on ASR.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6CExHRFMAi+ZaeAERAn9EAJ4swz+SFzwMmUEhClhc/jI4YoTiuQCeJBDF
dyTh9lXWYGwF4QAPJIdQNoU=
=UwLQ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
