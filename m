Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWCUOgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWCUOgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWCUOgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:36:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:41929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751720AbWCUOgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:36:52 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <200603220130.34424.kernel@kolivas.org>
References: <1142592375.7895.43.camel@homer>
	 <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer>
	 <200603220130.34424.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 15:36:58 +0100
Message-Id: <1142951818.7807.104.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 01:30 +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 01:28, Mike Galbraith wrote:
> > On Wed, 2006-03-22 at 01:19 +1100, Con Kolivas wrote:
> > > What you're fixing with unfairness is worth pursuing. The 'ls' issue just
> > > blows my mind though for reasons I've just said. Where are the magic
> > > cycles going when nothing else is running that make it take ten times
> > > longer?
> >
> > What I was talking about when I mentioned scrolling was rendering.
> 
> I'm talking about the long standing report that 'ls' takes 10 times longer on 
> 2.6 90% of the time you run it, and doing 'ls | cat' makes it run as fast as 
> 2.4. This is what Willy has been fighting with.

Oh.  I thought you were calling me a _moron_ :)

	-Mike

