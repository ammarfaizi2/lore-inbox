Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTD3GMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbTD3GMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:12:44 -0400
Received: from halo.ispgateway.de ([62.67.200.127]:55256 "HELO
	halo.ispgateway.de") by vger.kernel.org with SMTP id S262072AbTD3GMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:12:42 -0400
Subject: 2.5.68 and trouble with mouse setup on Notebook
From: Jens Ansorg <liste@ja-web.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LXrqJv8UfpNODt+3MwoP"
Organization: 
Message-Id: <1051683871.3692.42.camel@lisamobile>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 30 Apr 2003 08:25:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LXrqJv8UfpNODt+3MwoP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello,
I have an Dell Inspiron Notebook that has two pointer devices build in:
a Touchpad and a Trackstick (the mini Joystick placed in the keyboard
area)

while boot work fine in kernels of the 2.4.x series the Stick does not
work with a current development kernen (2.5.68)


The device just seems not there, no mention of it in the boot messages.

I get just


mice: PS/2 mouse device common for all mice
...
Found Synaptics Touchpad rev 5.7
input: PS/2 Synaptics TouchPad on isa0060/serio1


# ll /dev/input/
total 0
crw-r--r--    1 root     root      13,  63 Jan  1  1970 mice
crw-r--r--    1 root     root      13,  32 Jan  1  1970 mouse0


does anybody have an advice how to get the stick working?

thanks
Jens


--=20
Jens Ansorg <liste@ja-web.de>

--=-LXrqJv8UfpNODt+3MwoP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+r2wfpl1NTSh86yYRAjanAKDXds+MFuiqKmg0+h0aRiamnqg5CgCgn+Yd
3WrbuwUDYaEDxSDwtAcRGKg=
=1jnN
-----END PGP SIGNATURE-----

--=-LXrqJv8UfpNODt+3MwoP--

