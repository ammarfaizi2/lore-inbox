Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270845AbTHFSjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHFSjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:39:13 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:51347 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S270845AbTHFSjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:39:08 -0400
Subject: Processes dying by itself.
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N+mTKRq9Tx9kUYolDCQP"
Message-Id: <1060195146.2321.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 21:39:06 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N+mTKRq9Tx9kUYolDCQP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello, I was testing 2.6.0-test2 for my server (Pentium Classic 133 MHz,
32MiB RAM) it seemed to work fine, loads were pretty high (Didn't really
matter anyway) but when I left some processes on over night (screen,
irssi, apt-get dist-upgrade) it just killed all of them and killed even
my ssh connection. Is this a known issue on slow computers? it just
keeps on killing processes at some after some random idletime, no
problem with 2.4. I didn't find anything special in logs at that time. I
hope this could be fixed somehow.
Sorry for any typos.

Regards
--=20
Markus H=E4stbacka <midian@ihme.org>

--=-N+mTKRq9Tx9kUYolDCQP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MUtK3+NhIWS1JHARApCnAJ4rY0JsaTsGq3d/yo4hJqC35WDDAACgvbc7
4mWZn6JvC16MjGxsY0qK30w=
=YBYp
-----END PGP SIGNATURE-----

--=-N+mTKRq9Tx9kUYolDCQP--

