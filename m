Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132824AbRDRCdk>; Tue, 17 Apr 2001 22:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132926AbRDRCda>; Tue, 17 Apr 2001 22:33:30 -0400
Received: from topic-gw2.topic.com.au ([203.37.31.2]:42488 "HELO
	mailhost.topic.com.au") by vger.kernel.org with SMTP
	id <S132824AbRDRCdR>; Tue, 17 Apr 2001 22:33:17 -0400
Date: Wed, 18 Apr 2001 12:32:57 +1000
From: Jason Thomas <jason@topic.com.au>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac9
Message-ID: <20010418123257.D29749@topic.com.au>
In-Reply-To: <20010418120102.B29749@topic.com.au> <Pine.LNX.4.21.0104172224320.8771-100000@winds.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0104172224320.8771-100000@winds.org>; from gandalf@winds.org on Tue, Apr 17, 2001 at 10:26:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This particular motherboard is an ASUS CUV4X-DLS, the chipset is a
VIA694XDP, the IDE chipset however is a VIA686b.

I've seen this in all the kernels I've tried with the "ac" patches.

Any kernel I've tried that are NOT SMP work fine.


On Tue, Apr 17, 2001 at 10:26:26PM -0400, Byron Stanoszek wrote:
> > This does not seem to fix the problem with "clock timer", which
> > repeatedly prints the following message:
> >=20
> > probable hardware bug: clock timer configuration lost - probably a VIA6=
86a motherboard.
> > probable hardware bug: restoring chip configuration.
>=20
> I've seen this on my Dell P3 700 machine several times. Seems to happen a=
t odd
> intervals after I use my CD burner, but that just might be coincidental. =
But
> I'd like to point out that I've never seen this on my VIA686a itself. The=
 P3
> machine is UP too, not SMP. I saw this ever since I switched the machine =
to
> 2.4.2-ac8 and beyond (previously 2.2.18).
>=20
>  -Byron

--=20
Jason Thomas                           Phone:  +61 2 6257 7111
System Administrator  -  UID 0         Fax:    +61 2 6257 7311
tSA Consulting Group Pty. Ltd.         Mobile: 0418 29 66 81
1 Hall Street Lyneham ACT 2602         http://www.topic.com.au/

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63PzZ7cYwRJJSiL4RAj8AAJoCv/ZVri3jE8N1kuq5E+FY5g1FOQCgveCb
ndJu6HmavRkG97GrDvMmkTY=
=8xHB
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
