Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTI1I0o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 04:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTI1I0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 04:26:44 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:34028 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262348AbTI1I0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 04:26:42 -0400
Subject: Re: Linux 2.6.0-test6
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JV2aNBTUOevD86vZQSyW"
Message-Id: <1064737592.19950.1.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Sep 2003 11:26:32 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JV2aNBTUOevD86vZQSyW
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

CC [M]  drivers/net/wireless/arlan-main.o
drivers/net/wireless/arlan-main.c: In function `init_module':
drivers/net/wireless/arlan-main.c:1923: error: `probe' undeclared (first
use in this function)
drivers/net/wireless/arlan-main.c:1923: error: (Each undeclared
identifier is reported only once
drivers/net/wireless/arlan-main.c:1923: error: for each function it
appears in.)
make[3]: *** [drivers/net/wireless/arlan-main.o] Error 1
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Regards,
----
Markus H=E4stbacka <midian@ihme.org>

--=-JV2aNBTUOevD86vZQSyW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/dps33+NhIWS1JHARAq34AJ9ynHu+U4TWx/O7XoXwAVYV5PhsSQCgpbCU
q4O6se5Oux9MQusIJ4leZ6Y=
=LXhA
-----END PGP SIGNATURE-----

--=-JV2aNBTUOevD86vZQSyW--

