Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTIWUhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTIWUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:37:10 -0400
Received: from nan-smtp-03.noos.net ([212.198.2.72]:36154 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S262015AbTIWUhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:37:07 -0400
Subject: 2.6.0.test5-bk10 bio too big
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fFSFv3d4uU7tibRNLNAQ"
Organization: Adresse personnelle
Message-Id: <1064347633.3469.8.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 23 Sep 2003 22:07:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fFSFv3d4uU7tibRNLNAQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Since switching from 2.6.0-test5-bk9 to 2.6.0-test5-bk10 my logs are
flooded with :

Sep 23 21:58:27 rousalka kernel: bio too big device hdc1 (248 > 128)
Sep 23 21:58:27 rousalka kernel: bio too big device hdc1 (248 > 128)
Sep 23 21:58:27 rousalka kernel: raid1: hdc1: rescheduling sector
150669680
Sep 23 21:58:27 rousalka kernel: raid1: hdc1: redirecting sector
150669680 to another mirror

Should I worry ?

--=20
Nicolas Mailhot

--=-fFSFv3d4uU7tibRNLNAQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/cKfwI2bVKDsp8g0RAt08AKDpp/9CVmx95Chq4OctfHvaBya66gCfYxRN
QlicZmy2UuKzvFixPRhUPHc=
=vQg3
-----END PGP SIGNATURE-----

--=-fFSFv3d4uU7tibRNLNAQ--

