Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUGRSOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUGRSOa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 14:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUGRSO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 14:14:29 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:51179 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264371AbUGRSO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 14:14:26 -0400
Subject: Re: 2.6.8 rc2 still has keyboard trouble
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Steve Underwood <steveu@coppice.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <40FA7A83.60800@coppice.org>
References: <40FA7A83.60800@coppice.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7ZghSE+4euDbitTs8xKr"
Message-Id: <1090174625.5281.26.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Jul 2004 20:17:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7ZghSE+4euDbitTs8xKr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-18 at 15:26, Steve Underwood wrote:
> Hi all,
>=20
> It seems widely reported that recent versions of Linux do not work=20
> properly with non-USB keyboards and mice when built for SMP. I just=20
> tried 2.6.8rc2, and the problem is still there. The workaround many=20
> people have is to turn off USB legacy support in their BIOS. On my Tyan=20
> 2665 motherboard there is no BIOS option to do this. If I turn off USB=20
> support completely in the BIOS my machine runs OK, but then...... well,=20
> I want USB working :-) With a non-SMP kernel I do not have any problems.
>=20
> Is this problem being actively addressed by anyone, or is the "turn off=20
> legacy support" workaround considered an adequate fix?
>=20

Maybe try -rc1-mm1 (or whatever the latest) or try the bk-input.patch
from the latest, as I use it, with ps/2 keyboard and legacy usb
support enabled in the bios ...

--=20
Martin Schlemmer

--=-7ZghSE+4euDbitTs8xKr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA+r6hqburzKaJYLYRAiHdAJ0ZhtGIcu1H1VL4ZgSc21qo1MF6bgCeM68y
09lLrQRuzIsmsaBYW7rCVzs=
=3Y9W
-----END PGP SIGNATURE-----

--=-7ZghSE+4euDbitTs8xKr--

