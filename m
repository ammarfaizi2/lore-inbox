Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWHWU45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWHWU45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWHWU45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:56:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965198AbWHWU44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:56:56 -0400
Date: Wed, 23 Aug 2006 13:56:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-Id: <20060823135652.b491468b.akpm@osdl.org>
In-Reply-To: <20060823191132.GA13381@infradead.org>
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
	<20060823152831.GC32725@infradead.org>
	<20060823155715.GA5204@martell.zuzino.mipt.ru>
	<20060823160458.GA17712@infradead.org>
	<20060823115857.89f8d47b.akpm@osdl.org>
	<20060823191132.GA13381@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 20:11:32 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Aug 23, 2006 at 11:58:57AM -0700, Andrew Morton wrote:
> > > > Padding with zeros makes it even more useful:
> > > > 
> > > > 	[PATCH 00/17]
> > > > 	[PATCH 01/17]
> > > > 		...
> > > > 	[PATCH 17/17]
> > > 
> > > To be honest I utterly hate that convention
> > 
> > It's so they'll correctly alphasort at the recipient's end.
> 
> I suspect most mailers sort by date and not by subject anyway.
> 

Emails arrive out-of-order.

I used to have a `sleep 10' in my patch-bomb script to fix that, but half
an hour is too long to be sitting there hoping the DSL stays up, the kernel
stays up and that the familial hair-drier+iron+air-conditioner conspiracy
doesn't strike.  
