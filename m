Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTJIMQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJIMQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:16:59 -0400
Received: from M947P005.adsl.highway.telekom.at ([62.47.150.69]:9602 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S262105AbTJIMQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:16:56 -0400
Date: Thu, 9 Oct 2003 14:16:56 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] add CC Trivial Patch Monkey to SubmittingPatches
Message-ID: <20031009121656.GA14373@mail.sternwelten.at>
References: <20031009105228.GB1138@mail.sternwelten.at> <20031009122545.A16265@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20031009122545.A16265@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could you take care when spelling names to ensure that you get them
> correct *PLEASE*.  I for one are sick and tired of trying to get
> people to spell my name correctly.  Personally, I see it as an insult
> that people can't take the time to get it correct.

upps .. corrected!

as demonstrated by my signature,
i do personally not care about the spelling
of my own name so please don't take it as insult.
the german writer of "ziegelbrenner" used to confuse=20
autority with his many different names..

a++
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
+trivial@rustcorp.com.au set up by Rusty Russell which collects "trivial"=
=20
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

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hVG46//kSTNjoX0RAuTlAJ9k2ey2Vcf4mxH0qkkBrL6KRWIxAwCaA8RM
RqyIhoWnjn1oc3+Agda5wLg=
=8CAz
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
