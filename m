Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWDUPkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWDUPkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDUPkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:40:06 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:1708 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932216AbWDUPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:40:04 -0400
Message-ID: <4448FCC7.6070309@t-online.de>
Date: Fri, 21 Apr 2006 17:39:51 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mail/News 1.5 (X11/20060325)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.9, amd64, usbcore: NULL pointer dereference
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3D6765A42454D70BC5B071C3"
X-ID: bjJ0UUZfgebJxpg1KyiCS8YIcuNCzWnzB0BjnPqAk+sflQUdvhBD8c
X-TOI-MSGID: 9e0d73bc-031f-4b5c-9871-32253ff5d1f2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D6765A42454D70BC5B071C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

Sometimes my PC dies at boot time:

:
usb 3-3: config 1 has 0 interfaces, different from the descriptor's value=
: 1
Unable to handle kernel NULL pointer dereference at 000000000000000d RIP:=

<ffffffff8809493e>(:usbcore:usb_new_device+350)
:
:

Unfortunately it is not visible in any log file, so I took
a snapshot of the screen.

Surely it would be unacceptable to send huge attachments
to everybody on this list. Is somebody interested? Or is
there some upload area available, that I could use?

# lsusb
Bus 003 Device 003: ID 07cc:0301 Carry Computer Eng., Co., Ltd 6-in-1 Car=
d Reader
Bus 003 Device 002: ID 0ace:1211 ZyDAS 802.11b/g USB2 WiFi
Bus 003 Device 004: ID 124a:4023 AirVast
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000


Many thanx

Harri


--------------enig3D6765A42454D70BC5B071C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESPzMUTlbRTxpHjcRAtBOAKCHqkhoD5UYB42cLfRUZ4Gy7QVqCgCdE1ED
Jb9C5WCX+MzL9yBEmzGH8BQ=
=C6Fb
-----END PGP SIGNATURE-----

--------------enig3D6765A42454D70BC5B071C3--
