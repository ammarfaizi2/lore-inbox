Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283365AbRLDULW>; Tue, 4 Dec 2001 15:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283353AbRLDUKL>; Tue, 4 Dec 2001 15:10:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283405AbRLDUIb>; Tue, 4 Dec 2001 15:08:31 -0500
Subject: Re: hints at modifying kswapd params in 2.4.16
To: sven@research.nj.nec.com (Sven Heinicke)
Date: Tue, 4 Dec 2001 20:17:15 +0000 (GMT)
Cc: brownfld@irridia.com (Ken Brownfield),
        sven@research.nj.nec.com (Sven Heinicke), linux-kernel@vger.kernel.org
In-Reply-To: <15373.2398.495306.503255@abasin.nj.nec.com> from "Sven Heinicke" at Dec 04, 2001 12:35:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BM0B-0003JC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the AC kernel still have the old VM?  I really wanna stick the
> the new stuff but but a need a stable system.  Older kernels 2.4.8 had
> highmem issues, not the 2.4.16 has kswap issues.

There's a riel vm patch for 2.4.16 if you want to see if the vm thing is
the problem case

Alan
