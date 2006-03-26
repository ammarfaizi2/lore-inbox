Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWCZIlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWCZIlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 03:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWCZIlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 03:41:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:56792 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751223AbWCZIlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 03:41:25 -0500
X-Authenticated: #14349625
Subject: Re: swap prefetching merge plans
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200603261808.15785.kernel@kolivas.org>
References: <20060322205305.0604f49b.akpm@osdl.org>
	 <200603260944.26362.kernel@kolivas.org> <1143352497.7934.30.camel@homer>
	 <200603261808.15785.kernel@kolivas.org>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 09:42:27 +0200
Message-Id: <1143358947.9658.19.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 19:08 +1100, Con Kolivas wrote:
> On Sunday 26 March 2006 15:54, Mike Galbraith wrote:
> > On Sun, 2006-03-26 at 10:44 +1100, Con Kolivas wrote:
> > > On Sunday 26 March 2006 02:24, Nick Piggin wrote:
> > > > Jan Engelhardt wrote:
> > > > > When will Staircase go in?
> > > >
> > > > It is in... the queue ;)
> > >
> > > Hah you wish.
> > >
> > > No way would I let mainline benefit from something that good. I'm
> > > hoarding it for -ck only.
> >
> > Well, my box doesn't think it's _that_ good.
> 
> I guess you didn't get the extreme sarcasm in my comment.

I guess so.  I thought you were of the opinion that staircase would be a
good drop-in replacement for the stock scheduler.

> > I just got done doing some 
> > basic testing, and it is most definitely not ready for primetime.
> 
> I guess me criticising your patches made you want to find flaws with my code.

I was simply curious as to how well the damn thing performs Con.  Don't
worry though, I'll never make the mistake of testing and reporting ever
again.

	Later,

	-Mike

