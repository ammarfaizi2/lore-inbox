Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTFYGpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTFYGpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:45:11 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:5344
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262426AbTFYGpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:45:08 -0400
Date: Tue, 24 Jun 2003 23:59:18 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Synaptics driver won't work properly (2.5.73-mm1)
Message-ID: <20030625065918.GA28404@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Appending psmouse_noext to the kernel works, but basically i get a lot
of this when I try to move my synaptics touchpad without it:

Synaptics driver lost sync at 4th byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.

But the cursor goes nowhere. Would gpm work at all with the new
driver? I know I would need a new X11 driver for the mouse...

-Josh

--=20
A man may be so much of everything that he is nothing of anything.
        -- Samuel Johnson


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE++UhFT2bz5yevw+4RAoVMAKCUH7dS+Nu5pE+3QpzetotizWEmrwCaAqP+
H7GwwIqDSAleRd+VE23LtKY=
=9N8f
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
