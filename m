Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTDQRl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDQRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:41:56 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:21457 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261814AbTDQRlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:41:55 -0400
Subject: Re: Via-Rhine dirve in 2.4.21-pre7
From: Mark Syms <mark@marksyms.demon.co.uk>
To: rl@hellgate.ch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1049706637.963.6.camel@athlon>
References: <1049706637.963.6.camel@athlon>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kh6zcMVXBOEwwyJcFbuZ"
Organization: 
Message-Id: <1050602030.988.4.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Apr 2003 18:53:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kh6zcMVXBOEwwyJcFbuZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger,

Just saw your response on the mailing list archive. Sorry I haven't
responded earlier but as I said below I'm not subscribed to the list.

The reason I was trying 2.4.21-pre7 is that I have been unable to get
the network card working on any kernel version if local IO-APIC is
enabled and I was hoping that the changes you had submitted for the
21pre series might help but they did not.

If you want me to try anything let me know or send me a patch (directly
please).

Sorry not to be more help.

	Mark.

On Mon, 2003-04-07 at 10:10, Mark Syms wrote:
> Roger,
>=20
> Just tried the via-rhine driver in 2.4.21-pre7 and it appears to exhibit
> the problem Erik Hensema reported with the VT6103 onboard network card
> on my Chaintech 7VJL Athlon board whereby you get NETDEV Watchdog
> transmit timeout errors unless you turn local io-apic off in which case
> it all works fine.
>=20
> Please cc me directly as I'm not subscribed to the mailing list.
>=20
> Thank you,
>=20
> 	Mark Syms
--=20
Mark Syms <mark@marksyms.demon.co.uk>

--=-kh6zcMVXBOEwwyJcFbuZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+nuou+tS4l+honr0RAukjAKC7nQl/LKnJsQepbnKGlZHqj4ZBAgCgttGC
yqKYPLkAYfohidNCK/JOgFw=
=8OgB
-----END PGP SIGNATURE-----

--=-kh6zcMVXBOEwwyJcFbuZ--

