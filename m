Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267884AbTGOMqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbTGOMls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:41:48 -0400
Received: from bonn.shuttle.de ([194.95.249.247]:38600 "EHLO bonn.shuttle.de")
	by vger.kernel.org with ESMTP id S267978AbTGOMd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:33:27 -0400
Date: Tue, 15 Jul 2003 14:40:34 +0200
From: "Christian Garbs [Master Mitch]" <mitch@mitch.h.shuttle.de>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Matrox framebuffer does not build
Message-ID: <20030715124034.GA25488@yggdrasil.mitch.h.shuttle.de>
References: <20030714221642.GA23091@yggdrasil.mitch.h.shuttle.de> <Pine.LNX.4.44.0307142333280.17488-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307142333280.17488-100000@phoenix.infradead.org>
X-Accept-Language: de, en
X-LinuxCounter: Registered Linux User 158702 at http://counter.li.org
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
X-GPG-Key: http://www.h.shuttle.de/mitch/gpg-key
X-GPG-KeyID: E77F37EE
Organization: http://www.cgarbs.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2003 at 11:34:04PM +0100, James Simmons wrote:
>=20
> > I tried to upgrade my 2.4.21 .config to 2.6.0-test1.  The Matrox
> > framebuffer seems to create some problems: the kernel build fails.
>=20
> :-( I will look into it. It worked before.=20

Ooops, my bad:  I didn't set all of CONFIG_INPUT=3Dy, CONFIG_VT=3Dy,
CONFIG_VGA_CONSOLE=3Dy and CONFIG_VT_CONSOLE=3Dy as described in Known
Gotchas in post-halloween-2.5.txt.

Now the kernel builds fine.  I'll try booting it later.

Regards,
Christian
--=20
=2E...Christian.Garbs.....................................http://www.cgarbs=
=2Ede

Kommt ein Huhn in den Elektroladen:
"Ich h=E4tte gerne eine Legebatterie!"
--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/E/ZC50xh8Od/N+4RApc3AKC6FNQRekL4pyMAVdbLtel7X0+S3ACfQ+Rh
yLeiF/61RztDQEqTNlvpOoY=
=j7P2
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

