Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTLOUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTLOUjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:39:36 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:58753 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262198AbTLOUjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:39:25 -0500
Subject: Re: Nvidia kernel module and kernel 2.6
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Lukas Postupa <postupa@gmx.de>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1071519127.770.12.camel@linux>
References: <1071519127.770.12.camel@linux>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NReb+jx+1j4qQzKummHH"
Message-Id: <1071520756.20738.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 22:39:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NReb+jx+1j4qQzKummHH
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-15 at 22:12, Lukas Postupa wrote:
> Hello,
>=20
Hi!
> i'm using linux 2.6.0-test11-bk11 on Intel architecture (Celeron
> Coppermine) and nvidia kernel module 1.0-4620 for Nvidia GF FX 5200.
> Mttr registers are enabled.
> I applied appropriate patches from www.minion.de.
> After loading and using nvidia kernel module, dmesg shows this output:
> [...snip...]
I get these messages all the time with nvidia module, you can disable
these messages from the kernel configuration: "make menuconfig -> kernel
hacking -> sleep-inside-spinlock checking"
>=20
> This always is happening on loading this module.
> I get same trouble with nvidia kernel module 1.0-4496.
> I never had such problems with kernel 2.4 before.
>=20
You pribably didn't have that option enabled in the 2.4 kernel.
I don't know about the danger of this message, but it haven't caused me
any problems

Regards,
Markus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-NReb+jx+1j4qQzKummHH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/3hv03+NhIWS1JHARAgfaAJ9BBGmx503ICxtyDZ2vVaSERP8+TgCgxyxL
98TOulpjvaayaevhiMQUHyY=
=peOd
-----END PGP SIGNATURE-----

--=-NReb+jx+1j4qQzKummHH--

