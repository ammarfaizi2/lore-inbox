Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTKUJGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 04:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTKUJGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 04:06:15 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:16772 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264342AbTKUJGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 04:06:13 -0500
Subject: Re: Nick's scheduler v19a
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FBDAE99.9050902@cyberone.com.au>
References: <3FB62608.4010708@cyberone.com.au>
	 <1069361130.13479.12.camel@midux>  <3FBD4F6E.3030906@cyberone.com.au>
	 <1069395102.16807.11.camel@midux>  <3FBDAE99.9050902@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-huj2sefp1R4PXzwggIl+"
Message-Id: <1069405566.18362.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 21 Nov 2003 11:06:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-huj2sefp1R4PXzwggIl+
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi again.
I'm not sure if this is because of the patch or what, but my X crashes
normally in ~2 days, and the framebuffer gets all messy (green lines,
can't see what I'm typing, etc.), this doesn't happen with your patch at
all, only with vanilla kernel(s). Maybe my hardware likes your patch or
something. My X have been running for four days now without any kind of
problem on the patched kernel. (I'm not sure if it's the kernel or what,
but reported it anyway). That's the only problem I've been getting more
than often.

There's no other problems, only that the kernel standard scheduler is a
bit slower than yours.

Regards,
Markus

On Fri, 2003-11-21 at 08:20, Nick Piggin wrote:
> Well that's very good to hear :) err, just remember if you have
> any specific problems with unpatched 2.6 to make a report. We
> want the standard scheduler to run well too.
>=20
> Thanks,
> Nick
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-huj2sefp1R4PXzwggIl+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/vdV+3+NhIWS1JHARArSNAKCzYGKhNyC9d7uYUb3sisxoT1yUGwCfXKSq
zf0aaZBgm3jfGRfKUGamwxo=
=F0Up
-----END PGP SIGNATURE-----

--=-huj2sefp1R4PXzwggIl+--

