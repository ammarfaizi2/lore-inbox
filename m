Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTKTUpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTKTUpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:45:41 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:7082 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S261938AbTKTUpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:45:38 -0500
Subject: Re: Nick's scheduler v19a
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FB62608.4010708@cyberone.com.au>
References: <3FB62608.4010708@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qDrAE9NZKn7H8PqnME3a"
Message-Id: <1069361130.13479.12.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 20 Nov 2003 22:45:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qDrAE9NZKn7H8PqnME3a
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi nick! here's some feedback.
This one day last week, I thougt I could test your scheduler patch.
I noticed something really good with it. My X had really fast startup.
everything worked really fast. Even games worked much better than any in
kernel before (I've tested all from 2.5.74).

So I hope you'll port this patch for test10> if this one wont patch
clearly.

Thanks.
On Sat, 2003-11-15 at 15:11, Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/v19a/
>=20
> So the previous didn't exactly improve interactivity.
>=20
> This one seems to be better. Major thing is microsecond timeslice
> accounting. Other small fixes related to the microsecond stuff.
> No idea what this has done to context switch and wake up performance,
> but it should be able to be improved a bit.
>=20
> I've made patches for Linus and Andrew's trees.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-qDrAE9NZKn7H8PqnME3a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/vSfq3+NhIWS1JHARAhbVAJ9+2caJTvDFCfcgHKrNZYpIdTMS2QCfayfk
feawN8bTMkHqc9e1ACeJlNE=
=rcmr
-----END PGP SIGNATURE-----

--=-qDrAE9NZKn7H8PqnME3a--

