Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTIISvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTIISvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:51:08 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:39604 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264296AbTIISvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:51:04 -0400
Subject: Re: Nforce2
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <35272.165.89.84.86.1063127412.squirrel@www.genebrew.com>
References: <1063114472.589.4.camel@midux>
	 <35272.165.89.84.86.1063127412.squirrel@www.genebrew.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rK36vvAmEjDXsR35J7Rm"
Message-Id: <1063133451.965.4.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 21:50:52 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rK36vvAmEjDXsR35J7Rm
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-09 at 20:10, Rahul Karnik wrote:
> > Still problems with nvidia-agp on 2.6.0-test5(-mm1). I can't track down
> > the problem because my box needs a hard reboot.
>=20
> Did it work in previous 2.5/2.6 kernels? Does it work with the built-in
> AGP drivers? (NvAGP=3D1 I think)
>=20
> Thanks,
> Rahul
> --
> Rahul Karnik
> rahul@genebrew.com
> http://www.genebrew.com/
Hello Rahul,
No, it havent worked atleast since -test2, because that's when I bought
the new CPU, board and RAM. I'll try to come up with something. This 2.4
is a bit slow with these things, that's why I want to use 2.6, with old
computer there was a noticeable differnce in speed from 2.4 to 2.6. And
for others, I have the patch for nvidia drivers from minion.de. The card
worked _GREAT_ with my old board, untill test2, when I bought my new
board.

Thanks.
--=20
----
Markus H=E4stbacka <midian@ihme.org>

--=-rK36vvAmEjDXsR35J7Rm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/XiEL3+NhIWS1JHARAjK8AJ4zeYuZ2nSVM6PIymuJG8k2yxcRoACbBVUl
f+z5NzHq/uWteOK4hKrkTMw=
=8foo
-----END PGP SIGNATURE-----

--=-rK36vvAmEjDXsR35J7Rm--

