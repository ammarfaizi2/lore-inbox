Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753409AbWKCRwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbWKCRwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbWKCRwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:52:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50329 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1753409AbWKCRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:52:21 -0500
X-Sasl-enc: ee/1JxaUis8zjxwZIysc7EZuL7h10pA5thk5GX2SIhEv 1162576341
Message-ID: <454B8275.4050407@imap.cc>
Date: Fri, 03 Nov 2006 18:55:01 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.19-rc4-mm2] CONFIG_SYSFS_DEPRECATED=y needed for SuSE 10.0 network
 startup
References: <7cFEN-5PF-33@gated-at.bofh.it>
In-Reply-To: <7cFEN-5PF-33@gated-at.bofh.it>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig73959359F3D4D1EB9810DFBE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig73959359F3D4D1EB9810DFBE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

JFYI, setting the new SYSFS_DEPRECATED config option to N breaks
the SuSE 10.0 network startup scripts in the same way 2.6.18-rc7-mm1
did. Apparently SuSE's sophisticated tangle of scripts for starting
up network interfaces still needs those deprecated sysfs symlinks.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig73959359F3D4D1EB9810DFBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFS4J2MdB4Whm86/kRAgR+AJ4oh+qDpisWq7yui5TDS5aso/9rVQCfQtIq
rcjDfGyke868LHrhhNggEoc=
=zPLE
-----END PGP SIGNATURE-----

--------------enig73959359F3D4D1EB9810DFBE--
