Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWCZIIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWCZIIp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 03:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCZIIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 03:08:45 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:15068 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751172AbWCZIIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 03:08:44 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: swap prefetching merge plans
Date: Sun, 26 Mar 2006 19:08:14 +1100
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603260944.26362.kernel@kolivas.org> <1143352497.7934.30.camel@homer>
In-Reply-To: <1143352497.7934.30.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261808.15785.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 March 2006 15:54, Mike Galbraith wrote:
> On Sun, 2006-03-26 at 10:44 +1100, Con Kolivas wrote:
> > On Sunday 26 March 2006 02:24, Nick Piggin wrote:
> > > Jan Engelhardt wrote:
> > > > When will Staircase go in?
> > >
> > > It is in... the queue ;)
> >
> > Hah you wish.
> >
> > No way would I let mainline benefit from something that good. I'm
> > hoarding it for -ck only.
>
> Well, my box doesn't think it's _that_ good.

I guess you didn't get the extreme sarcasm in my comment.

> I just got done doing some 
> basic testing, and it is most definitely not ready for primetime.

I guess me criticising your patches made you want to find flaws with my code.

> It 
> has the same problem with sleep as the stock kernel does for instance.

Great to hear I am in such good company.

I don't suppose you know there is an interactive tunable in the full staircase 
set in -ck

Anyway this is all moot. I have no intention of pushing this code to mainline, 
but I thank you for your feedback with respect to it.

Cheers,
Con
