Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbUDTNqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUDTNqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 09:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTNqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 09:46:38 -0400
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:45068 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S262750AbUDTNqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 09:46:36 -0400
Subject: Re: Testing Dual Ethernet via Loopback
From: Antony Suter <suterant@users.sourceforge.net>
To: cryptic-lkml@bloodletting.com
Cc: List LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ivS4vc2SEZ4zRnncGS9B"
Message-Id: <1082468778.13813.4.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 23:46:18 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ivS4vc2SEZ4zRnncGS9B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


No special kernel is needed. You have a proper crossover cable
connecting your ethernet cards?

You simply have to assign ip addresses to each card properly. It might
be easiest to assign different subnets to each.
192.168.1.1/255.255.255.0 to the first and 192.168.2.1/255.255.255.0 to
the second. That should get you started.

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "...through shadows falling, out of memory and time..."

--=-ivS4vc2SEZ4zRnncGS9B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAhSmpZu6XKGV+xxoRAkjRAJ90+5EaWbw6BoAOCPW23QMjN6CNTQCgodb3
B2jrTOE3Q1K9Ebmfw+pX9ys=
=975U
-----END PGP SIGNATURE-----

--=-ivS4vc2SEZ4zRnncGS9B--

