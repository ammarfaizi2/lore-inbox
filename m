Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVH1BZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVH1BZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 21:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVH1BZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 21:25:52 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:33511 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S1751036AbVH1BZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 21:25:52 -0400
Message-ID: <43111298.80507@engr.orst.edu>
Date: Sat, 27 Aug 2005 18:25:44 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Radeon acpi vgapost
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D44079D2B1CC9DCC5A06DC0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D44079D2B1CC9DCC5A06DC0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thses patches resume ATI radeon cards from acpi S3 suspend when using
radeonfb by reposting the video bios. This is needed to be able to use
S3 when the framebuffer is enabled.
-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enig9D44079D2B1CC9DCC5A06DC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDERKdiP+LossGzjARAtU1AJ4+A73AVG6MqWth0CjBZxFtfnqjqwCeMyqC
KpxckgYgI7XlS7AJEkgqutg=
=R8DU
-----END PGP SIGNATURE-----

--------------enig9D44079D2B1CC9DCC5A06DC0--
