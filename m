Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTKUGLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 01:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTKUGLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 01:11:50 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:40156 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264310AbTKUGLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 01:11:47 -0500
Subject: Re: Nick's scheduler v19a
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FBD4F6E.3030906@cyberone.com.au>
References: <3FB62608.4010708@cyberone.com.au>
	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w4HEmeRkA4HTZ0g33XAj"
Message-Id: <1069395102.16807.11.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 21 Nov 2003 08:11:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w4HEmeRkA4HTZ0g33XAj
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi nick.
it seems that this patch changed everything, I patched against
2.6.0-test9-bk19. I didn't upgrade any software before I booted to your
patch. and I tested the 2.6.0-test9-bk22 without the patch it worked
just as all other kernels without the patch. I've had the same .config
from test3 (maybe some small changes if new drivers appeared).

I can't say that 2.6 performance is bad, it's better than 2.4, but now
this is even better.=20

So now I'm booted back to your patch and I like this difference in X
performance, I can't ask for more. :)

Regards,

Markus
On Fri, 2003-11-21 at 01:34, Nick Piggin wrote:
> Markus H=E4stbacka wrote:
>=20
> >Hi nick! here's some feedback.
> >This one day last week, I thougt I could test your scheduler patch.
> >I noticed something really good with it. My X had really fast startup.
> >everything worked really fast. Even games worked much better than any in
> >kernel before (I've tested all from 2.5.74).
> >
> >So I hope you'll port this patch for test10> if this one wont patch
> >clearly.
> >
>=20
> Hi Markus,
> Thanks for testing. That sounds quite remarkable, is it possible that
> some other change has made the difference? What kernel version did
> you patch against, and did you try that same kernel and .config without
> my patch? Anyway, I'm glad you're having good results.
>=20
> Yes, this one will probably apply to test10 should it ever apper. If not
> I will port it.
>=20
> Nick
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-w4HEmeRkA4HTZ0g33XAj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/vaye3+NhIWS1JHARAtXHAJ0U9EDojqFQiWWgf1If68W/g8xZVQCggaTI
/Eg/reFEZ9YzcTAtAYcm33I=
=04zM
-----END PGP SIGNATURE-----

--=-w4HEmeRkA4HTZ0g33XAj--

