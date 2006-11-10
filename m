Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424307AbWKJAVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424307AbWKJAVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424306AbWKJAVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:21:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424307AbWKJAVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:21:54 -0500
Date: Thu, 9 Nov 2006 16:18:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-Id: <20061109161813.5f0c706a.akpm@osdl.org>
In-Reply-To: <1163116618.8335.173.camel@localhost.localdomain>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	<1163024531.3138.406.camel@laptopd505.fenrus.org>
	<20061108145150.80ceebf4.akpm@osdl.org>
	<1163064401.3138.472.camel@laptopd505.fenrus.org>
	<20061109013645.7bef848d.akpm@osdl.org>
	<1163065920.3138.486.camel@laptopd505.fenrus.org>
	<20061109111212.eee33367.akpm@osdl.org>
	<1163100115.3138.524.camel@laptopd505.fenrus.org>
	<20061109211121.GW4729@stusta.de>
	<1163107915.3138.541.camel@laptopd505.fenrus.org>
	<1163116618.8335.173.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 00:56:58 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2006-11-09 at 22:31 +0100, Arjan van de Ven wrote:
> > > Since the first list I sent immediately after 2.6.19-rc1 was released, 
> > > kernel Bugzilla #7255 is part of my list of 2.6.19-rc regressions but 
> > > has gotten exactly zero developer responses.
> > 
> > where was the lkml mail for this?
> > 
> > > 
> > > What exactly were the mistakes of the submitter resulting in noone 
> > > caring about Bugzilla #7255?
> > 
> > he didn't post to lkml?
> 
> That's no excuse, as Adrian pointed it out on LKML since weeks.
> 
> Also the kernel.org bugzilla has a real flaw:
> 
> There is no way to get informed of new entries automatically and
> filtered by Category and Component. At least I did not find a way and
> bugme-admin@osdl.org seems to be a black hole.
> 
> The result is that you have to go to bugzilla on a regular base instead
> of getting automatic notifications of new entries. I do it once in a
> while, but it is really ineffective.
> 

I screen all bugzilla reports and I ensure that any of them which look like
they're real and which have a breathing maintainer are brought to that
maintainer's attention.

So no, I think the number of bugs in bugzilla which the relevant maintainer
didn't hear about is vanishingly small.

