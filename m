Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVAWVvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVAWVvR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVAWVvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 16:51:17 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:35224 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261362AbVAWVvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 16:51:13 -0500
Date: Sun, 23 Jan 2005 16:51:02 -0500
From: David Eger <eger@havoc.gtf.org>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc randomly crashes on my PowerBook with recent kernels...
Message-ID: <20050123215101.GA2430@havoc.gtf.org>
References: <20050113185453.GA10195@havoc.gtf.org> <9679B50C-6597-11D9-BBEE-000393AF911C@exactcode.de> <20050116000756.GA11442@havoc.gtf.org> <69DC51E6-6756-11D9-9044-000393AF911C@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69DC51E6-6756-11D9-9044-000393AF911C@exactcode.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 01:34:42AM +0100, René Rebe wrote:
> On 16. Jan 2005, at 1:07 Uhr, David Eger wrote:
>
> >>BenH mentioned PREEMPTION and ReiserFS (I use) might not
> >>play that well - at least not on PowerPC.
> >
> >Interesting.  I do have Pre-emption on (and I have Reiser compiled,
> >but not in use).  Sounds like time to kill it.
> 
> Could you reply if you have some recompiled kernel results?

Recompiling my kernel without PREEMPT seems to have fixed my problem...
I haven't had a gcc crash badly since...

-dte
