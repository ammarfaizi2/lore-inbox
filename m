Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWAQXvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWAQXvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWAQXvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:51:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWAQXva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:51:30 -0500
Date: Tue, 17 Jan 2006 15:50:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug tracking
Message-Id: <20060117155013.27507a1b.akpm@osdl.org>
In-Reply-To: <20060117231153.GG19398@stusta.de>
References: <OFA777C944.9337E52B-ONC12570C1.0039A0E1-C12570C9.004D661A@avm.de>
	<20060117224433.GF19398@stusta.de>
	<20060117150612.345571ef.akpm@osdl.org>
	<20060117231153.GG19398@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Tue, Jan 17, 2006 at 03:06:12PM -0800, Andrew Morton wrote:
> >...
> > c) Privately email the reporter, saying "if this bug is still present in
> >    2.6.15, please raise a report at bugzilla.kernel.org"
> > 
> > I've sent 100-200 of these emails in the past few days.  Of the people
> > who've responded, the great majority of these bugs were actually fixed, which
> > is nice.
> >...
> 
> Private emails have the disadvantage that noone else sees them.

Sure.  But given that I've given the reporter only two options:

a) Tell me it's fixed or

b) take it to bugzilla

I don't think there's much of interest to anyone else.  If the reporter
chooses to be awkward and starts going into details then yeah, cc's need to
be re-added.

> Does this imply that it can be assumed that you are tracking all 
> unresolved bug reports sent to linux-kernel until they are either 
> resolved or in Bugzilla?

No, I can miss stuff.  And there are lots more mailing lists.  Many of
them for drivers, which is where most of the bugs are.  

So please don't let me discourage you from doing this - if a reporter gets
multiple emails regarding a bug, he's unlikely to be offended - it's heaps
better than zero emails!  I'll cc you in future if you like so we can avoid
duplication.
