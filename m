Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUBOJjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBOJji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:39:38 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:8864 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S264428AbUBOJja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:39:30 -0500
Date: Sun, 15 Feb 2004 11:41:17 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Jon Smirl <jonsmirl@yahoo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: libata patch
In-Reply-To: <20040214160254.19491.qmail@web14902.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58L0.0402151138140.7324@ahriman.bucharest.roedu.net>
References: <20040214160254.19491.qmail@web14902.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

Hmm, I hit the same problem (only once so far) on 2.6.2 vanilla. While I 
was installing one of my first SATA systems, on ICH5, I hit the same thing 
(some error in kernel log regardning DMA and the SATA hdd seemed frozen, 
the only commands working were those cached in RAM already). Hope this 
helps :) (sorry I couldnt do more, it only happened once so far).

On Sat, 14 Feb 2004, Jon Smirl wrote:

> The latest 2.6 bk libata patch took my box down. It's a Dell PE400SC, 82801EB
> ICH5, SATA drives. It works for a little while then I get DMA errors, then I
> freeze.
> It had been working fine on 2.6 for months.
> 
> I have non-RAID ICh5. One SATA drive using libata and one ATA drive.
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Finance: Get your refund fast by filing online.
> http://taxes.yahoo.com/filing.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFALz6/PZzOzrZY/1QRAi2DAKCP7ZKlrY4NoqqOKEbSoCY+bgYKrQCfZDR8
7+HOPxqeGMOHf5VD+nB7eS0=
=vGHb
-----END PGP SIGNATURE-----
