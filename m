Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269526AbTGJUnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269587AbTGJUnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:43:23 -0400
Received: from foo209.internut.com ([209.181.68.209]:43441 "EHLO bartman")
	by vger.kernel.org with ESMTP id S269526AbTGJUnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:43:17 -0400
From: "Chuck Luciano" <chuck@mrluciano.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: My own 3.5G patch plus question on Ingo's 4G/$G patch
Date: Thu, 10 Jul 2003 14:56:33 -0600
Message-ID: <NFBBKNADOLMJPCENHEALGEAMGBAA.chuck@mrluciano.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <810600000.1057868412@flay>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you.

I realized I should have said that my patch goes on the REDHAT 2.4.18 kernel.

Sorry, still new to this.
cjl


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Martin J. Bligh
> Sent: Thursday, July 10, 2003 2:20 PM
> To: Chuck Luciano; Linux-Kernel
> Subject: Re: My own 3.5G patch plus question on Ingo's 4G/$G patch
> 
> 
> > On the subject of the 4G/4G patch, I started with 2.5.74, added 
> > patch-2.5.74-bk1 and http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8
> > and I get a hunk that fails:
> > 
> > patching file include/asm-i386/mmu_context.h
> > Hunk #1 FAILED at 29.
> > Hunk #2 succeeded at 38 (offset -5 lines).
> > Hunk #4 FAILED at 75.
> > 2 out of 4 hunks FAILED -- saving rejects to file include/asm-i386/mmu_context.h.rej
> > 
> > Is/are there a patch(es) that I'm missing?
> 
> Put it on top of the -bk6 snapshot.
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
