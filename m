Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRHLH5u>; Sun, 12 Aug 2001 03:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269000AbRHLH5l>; Sun, 12 Aug 2001 03:57:41 -0400
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:37259 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S268997AbRHLH5e>; Sun, 12 Aug 2001 03:57:34 -0400
Date: Sun, 12 Aug 2001 03:57:42 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: <10614.997602288@ocs3.ocs-net>
Message-ID: <Pine.A41.4.21L1.0108120353520.46568-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(not subbed to kbuild-devel, snipping)

On Sun, 12 Aug 2001, Keith Owens wrote:

> Very strange, drivers/sound/emu10k1/efxmgr.c is definitely in 2.4.8 but
> not in 2.4.8-pre.  The corrected emu10k1 list in kbuild-2.5-2.4.8-2
> added even more objects, but did not remove references to efxmgr.  I
> still think it was a bad source tree problem.  Oh well, it is "fixed" now.

2.4.8-pre does not contain efxmgr.c, passthrough.c, and passthrough.h,
which were in development after v0.7 EMU10K1 was brought into the kernel.

dtc

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

