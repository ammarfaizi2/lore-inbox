Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUGGRPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUGGRPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUGGRPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:15:03 -0400
Received: from mout0.freenet.de ([194.97.50.131]:15257 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S265236AbUGGRO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:14:59 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Willy Weisz <weisz@vcpc.univie.ac.at>
Subject: Re: APIC error on CPU0:60(60)
Date: Wed, 7 Jul 2004 19:14:41 +0200
User-Agent: KMail/1.6.2
References: <40EBFAF7.1080505@vcpc.univie.ac.at>
In-Reply-To: <40EBFAF7.1080505@vcpc.univie.ac.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kaya <kaya@emailkaya.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407071914.44496.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Search the archives for the subject "APIC Error on CPU 0"
I posted it to the list some months ago.

I get these messages every three minutes on 2.6.7.
On 2.6.7-mm6 I get the messages lets say every hour
once. So it's better, but not completely away.

I can't say if the reason is not a faulty CPU. Maybe,
maybe not. Who knows.

But the point is, that its actually is _better_ in -mm.


Quoting Willy Weisz <weisz@vcpc.univie.ac.at>:
> From time to time we get the error message:
>
>      APIC error on CPU0:60(60)
>
> from the kernel.
>
> We are running Linux kernel version 2.6.6 patches with
> Mike Peterson's perfctr.
>
> What does this message tell?
>
> Reagrds
>
> Willy

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7C+BFGK1OIvVOP4RAgRyAKCImdmKe3MetLuRUqYgXeBhTn7FvwCeKWnh
uPN/imDauTTDZw4pGAjp0xU=
=GE8C
-----END PGP SIGNATURE-----
