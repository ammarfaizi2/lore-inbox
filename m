Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTF0QEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTF0QEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 12:04:06 -0400
Received: from smtp1.clb.oleane.net ([213.56.31.17]:56780 "EHLO
	smtp1.clb.oleane.net") by vger.kernel.org with ESMTP
	id S264465AbTF0QEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 12:04:01 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tCx0W1NhJ+S9BRP/ow/r"
Organization: Adresse personelle
Message-Id: <1056730694.572.22.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 27 Jun 2003 18:18:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tCx0W1NhJ+S9BRP/ow/r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	Some people have already written part of what I'll say but I'll give a
quick POV anyway.

1. a single centralised database is *good*. This allows bugs to be
reassigned at need without loosing history (eg networking does not work
and investigation reveals its because of broken irq routing...). The
easiest way right now to kill a report is to ask to move it to another
mailing list.

2. bugs are never lost/ignored. They might move from maintainer to
maintainer but at least no one can feel "it involves x y z - I maintain
x but y or z maintainer are better suited to handle it, let them do it"

3. single human point-of-failure is a false problem - using a mailing
list as default assignee can help spread the load (one could say this
negates 2. but a small group of QA can insure no bug is left sleeping
overlong)

4. bugzilla is well known - it might have its warts but they are less
annoying for the average user that to have to learn rt... interface.

Regards,

--=20
Nicolas Mailhot

--=-tCx0W1NhJ+S9BRP/ow/r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/G5GI2bVKDsp8g0RAi1WAKDgBW1Xqbkt/kd2yUv29FYMbiwi5wCg3UDR
4YEhAPX403ZEJS9xffutSaQ=
=IEGa
-----END PGP SIGNATURE-----

--=-tCx0W1NhJ+S9BRP/ow/r--

