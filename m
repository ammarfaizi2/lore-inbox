Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbTGEKgR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 06:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbTGEKgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 06:36:17 -0400
Received: from maila.telia.com ([194.22.194.231]:61432 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S266324AbTGEKgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 06:36:15 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: Linux - 3Com 3CR990 driver
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: yogesh@unipune.ernet.in
Cc: dillowd@y12.doe.gov, linux-kernel@vger.kernel.org
In-Reply-To: <32995.196.1.114.224.1057226672.squirrel@unipune.ernet.in>
References: <32995.196.1.114.224.1057226672.squirrel@unipune.ernet.in>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EnxAOkjKQzSnXpoJO9T1"
Organization: LANIL
Message-Id: <1057402216.2295.46.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 05 Jul 2003 12:50:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EnxAOkjKQzSnXpoJO9T1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-03 at 12:04, Yogesh Subhash Talekar wrote:
> Hello,
>=20
> Firstly sorry for such an unexpected distrurbance. But I saw your posts o=
n
> Linux kernel lists which raised my hopes and hence this mail.
>=20
> We at University of Pune, India run the campus network whose backbone run=
s
> on OFC. We decided to upgrade it to 100 mbps from 10mbps and bought 3COM
> 3CR990 cards to install them in 20 Linux servers we have.
>=20
> Now that has landed us in big trouble. The driver which 3COM provided on
> CD-ROMs is not working. Also the one we downloaded from 3COM's website is
> also not working.
>=20
> Whenever we make the cards up and try to check simple FTP speeds from one
> machine to other it comes to about 800 kbps! We changed the CISCO-2990
> fiber switch to make sure that it is not because of the faulty switch..
> but in vein.
>=20
> We also tried 2.5.X but it fails to compile.
>=20
> Does anyone of you has a solution / advice/ code?
>=20
> Please help.....
>=20
> --yogesh talekar

Im also very intressed in this since I have a few off these (that works
like a charm under w2k btw).
Im CC:ing the LKML, maybe someone has more answers.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-EnxAOkjKQzSnXpoJO9T1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Bq1oyqbmAWw8VdkRAkXqAJ9vVRfo5xY0YqtDLbHVoUkDIDxnRACfa1er
3z4DYtKl8fsuG594s6dyCak=
=xY0R
-----END PGP SIGNATURE-----

--=-EnxAOkjKQzSnXpoJO9T1--

