Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUA2C4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 21:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266070AbUA2C4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 21:56:09 -0500
Received: from h80ad25b0.async.vt.edu ([128.173.37.176]:26752 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266011AbUA2C4F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 21:56:05 -0500
Message-Id: <200401290255.i0T2txQq013612@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?koi8-r?Q?=22?=Bansh=?koi8-r?Q?=22=20?= <bansh21@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL license and linux kernel modifications 
In-Reply-To: Your message of "Tue, 27 Jan 2004 19:25:55 +0300."
             <E1AlW2F-000N9k-00.bansh21-mail-ru@f13.mail.ru> 
From: Valdis.Kletnieks@vt.edu
References: <E1AlW2F-000N9k-00.bansh21-mail-ru@f13.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-965886751P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jan 2004 21:55:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-965886751P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jan 2004 19:25:55 +0300, =?koi8-r?Q?=22?=Bansh=?koi8-r?Q?=22=20?= <bansh21@mail.ru>  said:

> It looks like one can make a preprocessor or even one's own compiler (with
> one's syntax) which will be used for kernel building. But it's not required to
> distribute this compiler. So I can distribute linux kernel source code modified
> this way but no one will be able to build it. Is it ok?

Sure.  If you wrote the code in APL, it would be quite unreadable, and you could
distribute it.  See Bliss/32 (DEC) or PL/S (IBM) for examples of languages
that were used to write systems and the code distributed without a compiler.
(Note that I know of no source code in Bliss/32 or PL/S that was actually
distributed under the GPL).

> Such compiler/preprocessor can be really very tricky and can hide the
> modifications very much, thus allowing to hide proprietary know-how.

Yes, but it has to be the *preferred* source form.  So you have to distribute
what you're actually using to maintain the system.  You want to claim that
the very tricky code is your preferred form, go right ahead.  Let me know how
the first time you try to fix a bug goes. ;)

It is most certainly *NOT* allowed to pass your code through a obfuscator
before shipping it out.


--==_Exmh_-965886751P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAGHY/cC3lWbTT17ARAtAEAJ0ajIgYJgAPJsrWqZwDf+/dJRTEMwCgz3v3
huO5kow+UMeI83mmRgfLsgw=
=uC1Q
-----END PGP SIGNATURE-----

--==_Exmh_-965886751P--
