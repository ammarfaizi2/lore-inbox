Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTANSRW>; Tue, 14 Jan 2003 13:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTANSRW>; Tue, 14 Jan 2003 13:17:22 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:9952
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S264878AbTANSRU>; Tue, 14 Jan 2003 13:17:20 -0500
Date: Tue, 14 Jan 2003 10:25:56 -0800
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which FB to use instead of vesafb?
Message-ID: <20030114182556.GB16359@kanoe.ludicrus.net>
References: <20030114173348.GG20592@charite.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20030114173348.GG20592@charite.de>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Try rivafb, but I hear it is broken in 2.5 :)

Regards
Josh

On Tue, Jan 14, 2003 at 06:33:48PM +0100, Ralf Hildebrandt wrote:
> Which framebuffer works with a:
>=20
> 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 =
Go] (rev a3) (prog-if 00 [VGA])
>         Subsystem: Toshiba America Info Systems: Unknown device 0001
>         Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 10
>         Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
>         Memory at ec000000 (32-bit, prefetchable) [size=3D64M]
>         Memory at ebf80000 (32-bit, prefetchable) [size=3D512K]
>         Expansion ROM at <unassigned> [disabled] [size=3D128K]
>         Capabilities: <available only to root>
> =09
> --=20
> Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.=
de
> Charite Campus Mitte                            Tel.  +49 (0)30-450 570-1=
55
> Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-9=
16
> Basic research is what I'm doing when I don't know what I'm doing.
>                                               -- Wernher von Braun
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JFY06TRUxq22Mx4RAmsLAJ9h+EmvAXpce8aLStyT7aJZcbjF6ACgvruC
sDbzas0dICyRh8BKQZBq4N8=
=9f8L
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
