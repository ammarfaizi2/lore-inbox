Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267787AbTAHR2V>; Wed, 8 Jan 2003 12:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267788AbTAHR2V>; Wed, 8 Jan 2003 12:28:21 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:3296
	"EHLO localhost") by vger.kernel.org with ESMTP id <S267787AbTAHR2U>;
	Wed, 8 Jan 2003 12:28:20 -0500
Date: Wed, 8 Jan 2003 09:36:45 -0800
To: folkert@vanheusden.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of ntfs write-support in 2.4.20
Message-ID: <20030108173645.GA27118@kanoe.ludicrus.net>
References: <Pine.LNX.4.33.0301081507490.13070-100000@muur.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301081507490.13070-100000@muur.intranet.vanheusden.com>
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I believe it is still very unsafe. It *can* be done but you have to mess wi=
th
scandisk everytime you reboot back to windows...it's very very dirty and qu=
ite
hackish. I wouldn't think about risking data on an NTFS partition through t=
he
limited NTFS driver in Linux 2.4 (even 2.5.)

And windows NT/2000/XP partitions are all the same NTFS anyway.

Regards
Josh

On Wed, Jan 08, 2003 at 03:08:54PM +0100, folkert@vanheusden.com wrote:
> Hi,
>=20
> What is the status of NTFS WRITE(!)-support in 2.4.20?
> Is there any kernel which can do safely writing to windows nt(! not 2000
> or xp) partitions?
>=20
>=20
> Folkert
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HGGt6TRUxq22Mx4RAkV+AJ9yLx1f1Vo9HbSSO1EDwc68S1zGBwCfXgDF
W1YTDSfOkLtRpEPFW2U1QzE=
=+1Gb
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
