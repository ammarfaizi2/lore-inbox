Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbTIJSoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbTIJSoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:44:44 -0400
Received: from [207.188.30.29] ([207.188.30.29]:49443 "EHLO mpenc1.prognet.com")
	by vger.kernel.org with ESMTP id S265465AbTIJSom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:44:42 -0400
Date: Wed, 10 Sep 2003 11:44:40 -0700
From: Tom Marshall <tommy@home.tig-grr.com>
To: linux-kernel@vger.kernel.org
Subject: Synaptics Touchpad broken in 2.6.0-test
Message-ID: <20030910184439.GA3499@home.tig-grr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a Dell C400 laptop with both touchpad and pointing stick.  The
touchpad doesn't work in 2.6.0-test.  The driver reports that the reset
failed.

If I use psmouse_noext=3D1 on boot, the touchpad works but the pointing sti=
ck
does not.  Curiously, after an APM suspend/resume cycle, the pointing stick
works normally.

I can provide more detail (config, dmesg, etc.) if this problem isn't
already known and/or being investigated.

--=20
Any task can be completed in only one-third more time than is currently
estimated.
        -- Norman Augustine

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj9fcRcACgkQFMm9uvwPXW6ZDACdHtHrSDXs/xLfH50qH6/wOX1F
KZEAnAo0979l7EvvoYzZyKv/3wTFUbqB
=ijMD
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
