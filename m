Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263869AbRFDTIa>; Mon, 4 Jun 2001 15:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbRFDTIU>; Mon, 4 Jun 2001 15:08:20 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:11270
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S263797AbRFDTIB>; Mon, 4 Jun 2001 15:08:01 -0400
Date: Mon, 4 Jun 2001 12:07:57 -0700
From: Matthew Dharm <mdharm@one-eyed-alien.net>
To: Jerry Frana <franaj@coiinc.com>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: USB-storage and 2.4.2
Message-ID: <20010604120757.C31810@one-eyed-alien.net>
Mail-Followup-To: Jerry Frana <franaj@coiinc.com>,
	Kernel Developer List <linux-kernel@vger.redhat.com>
In-Reply-To: <200106040108.f5418D823560@mail.coiinc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106040108.f5418D823560@mail.coiinc.com>; from franaj@coiinc.com on Sun, Jun 03, 2001 at 08:08:25PM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Try 2.4.5, which has some assorted fixes that should solve this problem.

Matt

On Sun, Jun 03, 2001 at 08:08:25PM -0500, Jerry Frana wrote:
> Hi, i've been having a problem with my usb zip drive (older 100mb model)
>=20
> it's 100% repeateble:=20
>=20
> copy a large file to anywhere, and within a minute or so:=20
> copy stops dead.
> and the following appears in the syslog:
>=20
> Jun  3 21:10:56 int-21h kernel: uhci: host controller process error. some=
thing bad happened
> Jun  3 21:10:56 int-21h kernel: uhci: host controller halted. very bad
>=20
> my machine is a K6-3/350, kernel 2.4.2, via mvp3 chipset
>=20
> if you need any more info, please let me know,
>=20
> Thanks
> David F.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm@one-eyed-alien.net=
=20
Senior Software Designer, Momentum Computer

C:  Why are you upgrading to NT?
AJ: It must be the sick, sadistic streak that runs through me.
					-- Chief and A.J.
User Friendly, 5/12/1998

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7G9yNz64nssGU+ykRAjyyAKDotzigRFtb1RvtuZ8YEzzhavISIACggDZo
iY9tI1onyzpUqnAj1SeYj4I=
=L3gC
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
