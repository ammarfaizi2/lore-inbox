Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUEYStZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUEYStZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUEYStZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:49:25 -0400
Received: from mout2.freenet.de ([194.97.50.155]:6590 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S265038AbUEYStW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:49:22 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: System clock running too fast
Date: Tue, 25 May 2004 20:49:18 +0200
User-Agent: KMail/1.6.2
References: <200405251939.47165.mbuesch@freenet.de> <1085510708.1689.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1085510708.1689.1.camel@teapot.felipe-alfaro.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405252049.19704.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 25 May 2004 20:45, you wrote:
> Have you tried enabling CONFIG_HPET_TIMER *or* CONFIG_X86_PM_TIMER to
> see if it helps? They support high accuracy timers.

Do they need special hardware support, that may be
unavailable in such an old machine? You remember it's
a Pentium 1 Socket 7 With EDO Ram.
If not, I will try the options on my next planned kernel-update.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAs5UuFGK1OIvVOP4RAs0HAJ92YmqGps1iKEibRaFsJPdlERoP5gCgj1qL
bTa7dFBC9NHk0QfIUP42/aM=
=Lhlo
-----END PGP SIGNATURE-----
