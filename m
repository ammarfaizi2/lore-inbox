Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVCDN7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVCDN7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVCDN7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:59:53 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:34731 "EHLO harmonie.imag.fr")
	by vger.kernel.org with ESMTP id S262835AbVCDN7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:59:49 -0500
Message-ID: <422869BA.3030802@naurel.org>
Date: Fri, 04 Mar 2005 14:59:22 +0100
From: =?ISO-8859-1?Q?Aur=E9lien_Francillon?= <aurel@naurel.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm1
References: <20050304033215.1ffa8fec.akpm@osdl.org>
In-Reply-To: <20050304033215.1ffa8fec.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD1A688F776F39104237273B2"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (harmonie.imag.fr [147.171.130.40]); Fri, 04 Mar 2005 14:59:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-MailScanner-From: aurel@naurel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1A688F776F39104237273B2
Content-Type: multipart/mixed;
 boundary="------------030900040609070205040409"

This is a multi-part message in MIME format.
--------------030900040609070205040409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.=
6.11-mm1/
>=20
>=20

trivial patch for fscache menuconfig help documentation path

Signed-off-by: Aur=E9lien Francillon <aurel@naurel.org>



--------------030900040609070205040409
Content-Type: text/plain;
 name="fscache-menuconfig-help-fix-documentation-path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fscache-menuconfig-help-fix-documentation-path.patch"

--- 2.6.11-mm1/fs/Kconfig~	2005-03-04 14:32:34.000000000 +0100
+++ 2.6.11-mm1/fs/Kconfig	2005-03-04 14:33:36.000000000 +0100
@@ -445,7 +445,7 @@
 	  locally. Diffent sorts of caches can be plugged in, depending on the
 	  resources available.
 
-	  See Documentation/filesystems/fscache.txt for more information.
+	  See Documentation/filesystems/caching/fscache.txt for more information.
 
 config CACHEFS
 	tristate "Filesystem caching filesystem"

--------------030900040609070205040409--

--------------enigD1A688F776F39104237273B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCKGm6tsnPPsovZP0RApv3AJ9umZr8WhA5aX6xje06OXqzaUltBACaAvFg
6GIedmsXFyJjel5IxI29dMQ=
=PxXj
-----END PGP SIGNATURE-----

--------------enigD1A688F776F39104237273B2--
