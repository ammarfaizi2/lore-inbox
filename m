Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbTGTX2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269085AbTGTX2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:28:07 -0400
Received: from maila.telia.com ([194.22.194.231]:53453 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S269077AbTGTX2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:28:02 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: Error Compiling mm2
From: Christian Axelsson <smiler@lanil.mine.nu>
To: Pedro Ribeiro <deadheart@netcabo.pt>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1B8447.1090401@netcabo.pt>
References: <3F1B8447.1090401@netcabo.pt>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RqgeFAl7aZchPQqPBE4w"
Message-Id: <1058744574.32319.4.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 01:42:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RqgeFAl7aZchPQqPBE4w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-21 at 08:12, Pedro Ribeiro wrote:
> I get this error when I try to compile mm2:
>=20
> drivers/video/riva/fbdev.c: In function `rivafb_cursor':
> drivers/video/riva/fbdev.c:1525: warning: passing arg 2 of=20
> `move_buf_aligned' from incompatible pointer type
> drivers/video/riva/fbdev.c:1525: warning: passing arg 4 of=20
> `move_buf_aligned' makes pointer from integer without a cast
> drivers/video/riva/fbdev.c:1525: too few arguments to function=20
> `move_buf_aligned'
> drivers/video/riva/fbdev.c:1527: warning: passing arg 2 of=20
> `move_buf_aligned' from incompatible pointer type
> drivers/video/riva/fbdev.c:1527: warning: passing arg 4 of=20
> `move_buf_aligned' makes pointer from integer without a cast
> drivers/video/riva/fbdev.c:1527: too few arguments to function=20
> `move_buf_aligned'
> make[3]: *** [drivers/video/riva/fbdev.o] Error 1
> make[2]: *** [drivers/video/riva] Error 2
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2

RivaFB is currently broken and needs a rewrite.
James Simmons is currently working on this I think.

--=20
Christian Axelsson
  smiler@lanil.mine.nu

GPG ID:
  6C3C55D9 @ ldap://keyserver.pgp.com

--=-RqgeFAl7aZchPQqPBE4w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Gyj9yqbmAWw8VdkRAtTHAJ9CSPecl7y/HCACLNnIeYe7asY6iQCg5sIP
aElfh5vt7Q5mhnNbmn9AODU=
=ufoa
-----END PGP SIGNATURE-----

--=-RqgeFAl7aZchPQqPBE4w--

