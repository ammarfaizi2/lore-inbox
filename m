Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTKUJdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 04:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbTKUJdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 04:33:07 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:1416 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264343AbTKUJdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 04:33:04 -0500
Subject: Re: Nick's scheduler v19a
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FBDD790.5060401@cyberone.com.au>
References: <3FB62608.4010708@cyberone.com.au>
	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au>
	 <1069395102.16807.11.camel@midux>  <3FBDAE99.9050902@cyberone.com.au>
	 <1069405566.18362.5.camel@midux>  <3FBDD790.5060401@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tTRErBwQ5kfXnsCxnURx"
Message-Id: <1069407179.18505.11.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 21 Nov 2003 11:32:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tTRErBwQ5kfXnsCxnURx
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

but I wonder why the frambuffer gets messy too, I've heard that it's
pretty normal that X crashes sometimes under high load, but this of
course don't happen with your patch, I'm using debian sid, and of
course, I like to live on the edge.

And I don't see why I should report this, while it works now.

Regards,
Markus

On Fri, 2003-11-21 at 11:14, Nick Piggin wrote:
> Well yes its possible that my scheduler is better at hiding some bug. It
> wouldn't be fixing anything, of course. It definitely was better at
> exposing a kernel or postgresql bug when running OSDL's PostgreSQL tests =
-
> I saw the crash 3 times I think, though never with standard kernel.
>=20
> I don't know how you should be reporting X crashes. I guess you could rep=
ort
> the bug to the XFree86 guys as per their guidelines if you can reproduce =
the
> crashes with an up to date 2.4 kernel.
>=20
> Nick
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-tTRErBwQ5kfXnsCxnURx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/vdvL3+NhIWS1JHARAqQSAJ91GQ+JK4B+JN9o43OFV45Xg93wgwCdFj0J
mcG1oP8tZ2e+DINPN0APIaM=
=ynC+
-----END PGP SIGNATURE-----

--=-tTRErBwQ5kfXnsCxnURx--

