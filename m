Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132128AbQLNKmp>; Thu, 14 Dec 2000 05:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132261AbQLNKm1>; Thu, 14 Dec 2000 05:42:27 -0500
Received: from quechua.inka.de ([212.227.14.2]:13110 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132128AbQLNKmM>;
	Thu, 14 Dec 2000 05:42:12 -0500
From: Martin Bahlinger <inka-user@mb.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: test12 lockups -- need feedback
Message-Id: <E146VMY-0000J1-00@sites.inka.de>
Date: Thu, 14 Dec 2000 11:11:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A3804CA.E07FDBB1@haque.net> you wrote:
> At first I thought it was just me when I reported the lockups I was
> having with test12 earlier this week. Now the reports are flooding. Of
> course, now my machine isn't locking up anymore after recompiling from a
> clean source tree (test5 w/ patches through test12)

> Now, I'm trying to determine what the common element is.

> Those of you who are having lockups, was test12 compiled from a patched
> tree that you've previously compiled?

I compiled from a clean source tree test7 with patches through test12.
My machine gets locked up directly after starting the xfree-3.3.6 mach64
server. I'm running Debian2.3 woody here on a P90 w/ 32MB Ram.

> Those that are locking up in X. Do you have a second machine you can
> hook up via serial port to grab Oops output?

If it's still necessary, contact me via email.

-- 
Martin.Bahlinger@rz.uni-karlsruhe.de   (PGP-ID: 0x0506D9B7)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
