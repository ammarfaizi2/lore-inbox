Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTJIK4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTJIK4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:56:04 -0400
Received: from M947P005.adsl.highway.telekom.at ([62.47.150.69]:2433 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S261971AbTJIKw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:52:29 -0400
Date: Thu, 9 Oct 2003 12:52:28 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] add CC Trivial Patch Monkey to SubmittingPatches
Message-ID: <20031009105228.GB1138@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

rusty you may want to review your rules before this gets in ;)

the "Trivial Patch Monkey" is neither documented in MAINTAINERS
nor was there a note in SubmittingPatches, i hope this helps
further recognition and easier catch

so let the monkey apply himself in re-transmission mode!

please apply
ma(ks|x(imilian)?)

--- linux-2.6.0-test7/Documentation/SubmittingPatches	2003-10-08 21:24:00.0=
00000000 +0200
+++ linux/Documentation/SubmittingPatches	2003-10-09 12:41:22.000000000 +02=
00
@@ -132,6 +132,21 @@
 Even if the maintainer did not respond in step #4, make sure to ALWAYS
 copy the maintainer when you change their code.
=20
+For small patches you may want to CC Trivial Patch Monkey=20
+trivial@rustcorp.com.au set up by Rusty Russel which collects "trivial"=20
+patches. Trivial patches must qualify for one of the following rules:
+ Spelling fixes in documentation
+ Spelling fixes which could break grep(1).
+ Warning fixes (cluttering with useless warnings is bad)
+ Compilation fixes (only if they are actually correct)
+ Runtime fixes (only if they actually fix things)
+ Removing use of deprecated functions/macros (eg. check_region).
+ Contact detail and documentation fixes
+ Non-portable code replaced by portable code (even in arch-specific,=20
+ since people copy, as long as it's trivial)
+ Any fix by the author/maintainer of the file. (ie. patch monkey=20
+ in re-transmission mode)
+
=20
=20
 6) No MIME, no links, no compression, no attachments.  Just plain text.

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hT3s6//kSTNjoX0RAjz8AJ0crxTVponPy8JPbRvXXiM7+BJyPACfa3ds
kPAHZ094/DL/ZVT7/6dTekk=
=KzOz
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
