Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUALWcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUALWcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:32:43 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:15541 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266543AbUALWcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:32:41 -0500
Subject: 2.6.1: Keycode changes, reasons?
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UvWVbxLygESrhY+nVpRm"
Message-Id: <1073946759.457.4.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 00:32:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UvWVbxLygESrhY+nVpRm
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ok, I tried to upgrade from 2.6.0 to 2.6.1 today, after what I noticed
my ' key isn't working, after what I did try with xmodmap etc and never
got it working (Seems that it had changed from keycode 51 to 92)

The question is why this is changed? You knew it would broke peoples
keycodes, and will take like a year before it's fixed.

The only problem for me isn't only the ' key, but the "Multimedia keys"
in my Logitech keyboard, they don't work anymore after the keycodes
changed.

And is it safe to remove the keycode change line from the patch?

Kind regards,
Markus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-UvWVbxLygESrhY+nVpRm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAyCG3+NhIWS1JHARAgkOAKDhORpJaX9P385y4UpuKa23i5vr2gCfSjri
Nk8+uAbh9nVDezqo9+MFQ0M=
=9Glf
-----END PGP SIGNATURE-----

--=-UvWVbxLygESrhY+nVpRm--

