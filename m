Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTLHUzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLHUzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:55:38 -0500
Received: from [199.45.143.209] ([199.45.143.209]:23301 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262291AbTLHUz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:55:28 -0500
Subject: Re: Of Mice and Linux
From: Zan Lynx <zlynx@acm.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FD4BD1B.1060708@coyotegulch.com>
References: <3FD4BD1B.1060708@coyotegulch.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UO1sTUiWve2p6foAqIoB"
Organization: 
Message-Id: <1070916926.20390.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Dec 2003 13:55:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UO1sTUiWve2p6foAqIoB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-08 at 11:04, Scott Robert Ladd wrote:
> Please indulge a minor story in regard to testing beta kernels.
>=20
> Last Friday, I made a minor change to my Linux .config and rebuilt=20
> 2.6.0-test11. Soon thereafter, my mouse began getting "stuck", sometimes=20
> for several seconds, refusing to move no matter how vigorously I wiggled=20
> my wrist.
>=20
> I rebuilt the kernel a couple of times, turning on and off various=20
> options; I plugged and unplugged devices from the USB ports; a=20
> considerable amount of cursing ensued. The problem was erratic -- and=20
> frustrating, because I hadn't had much trouble with 2.6 (which I've been=20
> using since the 2.6.4x days).
>=20
> Then I borrowed a mouse from another machine, plugged it in -- and the=20
> replacement rodent worked flawlessly. It seems that my mouse broke just=20
> about the same time as I installed test11. Being a software guy, I=20
> should have blamed the hardware first...
>=20
> ...especially since the truth was right in front of me, emblazoned=20
> boldly across the mouse: the word "Microsoft".
>=20
> I think the replacement will be from Logitech.

Are you _sure_ your mouse is broken?  Did you try your Microsoft mouse
on another machine?

I ask because my Microsoft Intellimouse wireless started doing the same
thing after I installed 2.6.0-test11.  I haven't made a bug report
because I haven't had time to bother retrying -test10, removing the
binary Nvidia drivers, and taking out the Reiser4 patches.

But now that you've mentioned the same problem, I'm going to add a "Me
Too!"

And on a different machine, I'm using a Logitech MX700, and it works
perfectly under -test11.
--=20
Zan Lynx <zlynx@acm.org>

--=-UO1sTUiWve2p6foAqIoB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/1OU9G8fHaOLTWwgRAg/lAJ4g70nqp/mx6nIuz77l3X5NX+GuswCgn7ss
/wIQo4csx3Lxi+xXLLo1A2I=
=fsfi
-----END PGP SIGNATURE-----

--=-UO1sTUiWve2p6foAqIoB--

