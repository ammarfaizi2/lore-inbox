Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbTIXSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbTIXSc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 14:32:58 -0400
Received: from nan-smtp-13.noos.net ([212.198.2.121]:913 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S261596AbTIXSc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 14:32:56 -0400
Subject: PS2 keyboard & mice mandatory again ?
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wx8ABhVOstm5UM+xIJZd"
Organization: Adresse personnelle
Message-Id: <1064428364.1673.11.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 24 Sep 2003 20:32:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wx8ABhVOstm5UM+xIJZd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	I've just had the unpleasant surprise to find out that in the latest
2.6 snapshots

CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy

is forced on everyone. I know the modularization of 8042 has generated a
lot of bug reports, but couldn't people just fix the damn option name
and description instead of making it mandatory ?

There are already a lot of people  (me included) with a 100% usb input
setup. More are on the way (really a nice hub on the desk instead of
crawling under it to reach PS/2 ports is a no-brainer once you've tested
it). Please revert this change.=20

Cheers,

--=20
Nicolas Mailhot

--=-wx8ABhVOstm5UM+xIJZd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ceNLI2bVKDsp8g0RArpyAJ0b+TVuGnKy+RxkTTW1zj8BBYwQkACgm2ot
dg2VMUX+fMXIHS7UPpKdpqI=
=YB6Y
-----END PGP SIGNATURE-----

--=-wx8ABhVOstm5UM+xIJZd--

