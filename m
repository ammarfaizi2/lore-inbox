Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUDVLqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUDVLqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbUDVLqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:46:49 -0400
Received: from 82-68-84-57.dsl.in-addr.zen.co.uk ([82.68.84.57]:944 "EHLO
	lenin.trudheim.com") by vger.kernel.org with ESMTP id S263969AbUDVLqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:46:39 -0400
Subject: ACPI S3
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oyKsbzhTQiAM5NSRr4/8"
Organization: Trudheim Technology Limited
Message-Id: <1082634395.3033.5.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Apr 2004 12:46:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oyKsbzhTQiAM5NSRr4/8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Got a little problem with ACPI on a Thinkpad X31. I am running kernel
2.6.5 on it, and am experimenting with suspending it (to state S3).

It suspends alright, but switches on the backlight. That is not quite so
useful. Is there anything I can do to switch that backlight of through
ACPI?

The sleep script switches off the displays in X (works, tried and
tested) but once ACPI drops into sleep state, the backlight comes back
on. :-/

I am game for testing patches etc.

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-oyKsbzhTQiAM5NSRr4/8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAh7CaLYywqksgYBoRAs4DAJ9rN0syv6StdGG9hUQF0imPWppzOACgmHqi
+151ARwrCErihhF3NIU3gnQ=
=ldTY
-----END PGP SIGNATURE-----

--=-oyKsbzhTQiAM5NSRr4/8--

