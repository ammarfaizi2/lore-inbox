Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTFCRst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTFCRst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:48:49 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:14976 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261265AbTFCRsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:48:47 -0400
Subject: Re: Linux 2.4.21-rc6
From: Anders Karlsson <anders@trudheim.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Michael Frank <mflt1@micrologica.com.hk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200306031903.06297.m.c.p@wolk-project.de>
References: <20030529052425.GA1566@moonkingdom.net>
	 <200306040030.27640.mflt1@micrologica.com.hk>
	 <200306031859.59197.m.c.p@wolk-project.de>
	 <200306031903.06297.m.c.p@wolk-project.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9IiWmJM0CXDT4FLEgl4D"
Organization: Trudheim Technology Limited
Message-Id: <1054663333.2066.5.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92Rubber Turnip www.usr-local-bin.org
	(Preview Release)
Date: 03 Jun 2003 19:02:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9IiWmJM0CXDT4FLEgl4D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good Evening,

On Tue, 2003-06-03 at 18:03, Marc-Christian Petersen wrote:
> On Tuesday 03 June 2003 18:59, Marc-Christian Petersen wrote:
>=20
> Hi again,
>=20
> > well, very easy one:
> > dd if=3D/dev/zero of=3D/home/largefile bs=3D16384 count=3D131072
> > then use your mouse, your apps, switch between them, use them, _w/o_
> > pauses, delay, stops or kinda that. If _that_ will work flawlessly for
> > everyone, then it is fixed, if not, it _needs_ to be fixed.
> I forgot to mention. If you have more than 2GB free memory (the above one=
 will=20
> create a 2GB file), the test is useless.
>=20
> Have less memory free, so the machine will swap, doesn't matter if the sa=
me=20
> disk or another or whatever!

Would it count if I said I run 2.4.21-rc6-ac1 and had 768MB RAM, ended
up using about 250MB swap and when I today suspended VMware and closed a
few gnome-terminals, Galeon and Evolution, the mouse cursor would not
move, then jump half way across the screen after a second, then 'stick'
again before doing another jump.

I thought it sounded a little like what you are describing. If more
details are required, let me know and I will try and collect what is
asked for.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-9IiWmJM0CXDT4FLEgl4D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+3OKlLYywqksgYBoRAscuAJ0VtXjTkNzKKj7yvpUiWrASCsoDBgCfRqAQ
uZ2CVzKlHGATmcT+XxqE4wo=
=LmpR
-----END PGP SIGNATURE-----

--=-9IiWmJM0CXDT4FLEgl4D--

