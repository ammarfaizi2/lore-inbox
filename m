Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTLBUA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbTLBUA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:00:29 -0500
Received: from mout2.freenet.de ([194.97.50.155]:8911 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S264333AbTLBUAW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:00:22 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "Stefan J. Betz" <stefan_betz@gmx.net>
Subject: Re: include/linux/version.h
Date: Tue, 2 Dec 2003 21:00:13 +0100
User-Agent: KMail/1.5.93
References: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
In-Reply-To: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200312022100.14880.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 02 December 2003 19:35, Stefan J. Betz wrote:
> Hello People,

Hi Stefan,

> i have found some wrong thing in include/linux/version.h
> On my System i have Kernel 2.6.0-test10 & 2.6.0-test11, but in
> include/linux/version.h i see:
> #define UTS_RELEASE "2.6.0-test9"
>
> correct where:
> #definde UTS_RELEASE "2.6.0-test11" (for Linux Kernel 2.6.0-test11)...

Hm, I think that file is automatically generated at compile-time,
isn't it?
Are you sure, you grepped through the correct tree? Or is this
an old one, that was sitting in some dusty corner on your disk?

> Greeting Betz Stefan
>
> I know that my english is not realy good, but any tipp how i can learn
> better english is welcome...

Don't read my mails, because they are ugly english, too. 8-)

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zO9NoxoigfggmSgRAhLMAJ43jo4/Pw7em+LbHRMUB4rgn/79EACfb8xa
fAFiprdxGFZE+aBLRePHS5s=
=6MLE
-----END PGP SIGNATURE-----
