Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUAJL21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUAJL20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:28:26 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:40842 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S265080AbUAJL2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:28:23 -0500
Date: Sat, 10 Jan 2004 12:28:19 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: phidgets developer list <phidgets@lists.ailab.ch>
Subject: enumerating HID devices
Message-ID: <20040110112819.GA8513@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	phidgets developer list <phidgets@lists.ailab.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Is there an easy way in Linux to enumerate all HID devices, other
than iterating /dev/usb/hiddev* ? E.g. in OS X, one accesses
a linked list of all HID devices to connect to one.

Also, is there a different way to access these devices than through
the device node? The problem is that the assignment of node to
device is not at all static and makes it difficult to work with.

Pointers, hints, tipps, tricks, and friendly flames (e.g. RTFM) are
greatly appreciated.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
you can't assign IP address 127.0.0.1 to the loopback adapter,
because it is a reserved address for loopback devices.
                                  -- micro$oft windoze xp professional

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//+HTIgvIgzMMSnURApCBAKDS4+Ps+XmpijfOeusCSHU7d48WSwCfcecK
QQyBkFBRLDzm+aP0ZppVYkM=
=2/CR
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
