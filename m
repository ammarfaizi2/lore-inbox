Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270939AbTGVQwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 12:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270940AbTGVQwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 12:52:21 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:49889 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S270939AbTGVQwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 12:52:06 -0400
Subject: Re: no EMU10k1 Sound on 2.6.0-test1-ac2
From: Max Valdez <maxvalde@fis.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030722160242.GA23041@mikamyla.com>
References: <1058867364.13457.4.camel@garaged.homeip.net>
	 <20030722160242.GA23041@mikamyla.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VdyXjPWqueCUO10l7+FY"
Message-Id: <1058875762.4013.1.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 07:09:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VdyXjPWqueCUO10l7+FY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I will try that later.

I changed to the oss driver and everything is fine, no skips on sound,
and i can actually hear mp3 :-), the weird thing is that test1 and
test1-ac1 didnt had any problem.

I will try ur comment on next reboot, thanks Dave !
Max


On Tue, 2003-07-22 at 11:02, Dave Barry wrote:
> Quothe Max Valdez <maxvaldez@yahoo.com>, on Tue, Jul 22, 2003:
> > Hi,
> >=20
> > Is anybody having problems with alsa sound on 2.6.0-test1-ac2 ??
> >=20
> > I have all my modules mounted, and this time, I can even look the tree
> > with lsmod (couldnt do it with any other 2.5.X or 2.6-0-test1). But my
> > speakears dont get any signal :-(.
> >=20
> > Sound worked perfect on test1-ac1. and test1 too.
>=20
> Hi,=20
>=20
> This may not help, but on my system, I had to use alsamixer to mute the
> digital out channel (which was enabled by default) to hear sound via the
> analog channels.
--=20
Linux garaged 2.6.0-test1-ac1 #2 SMP Tue Jul 15 06:25:03 CDT 2003 i686 Pent=
ium III (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-VdyXjPWqueCUO10l7+FY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HSlxsrSE6THXcZwRAhTVAKC1Pr8yZNuKz1eGLW6QYhcGC7BRvQCeMSgE
wM5CZRFYVistxgvFFY2NIS0=
=JQOB
-----END PGP SIGNATURE-----

--=-VdyXjPWqueCUO10l7+FY--

