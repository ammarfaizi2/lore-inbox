Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSHTXwz>; Tue, 20 Aug 2002 19:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSHTXwz>; Tue, 20 Aug 2002 19:52:55 -0400
Received: from dp.samba.org ([66.70.73.150]:36581 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317701AbSHTXwz>;
	Tue, 20 Aug 2002 19:52:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (re-xmit): kprobes for i386 
In-reply-to: Your message of "Tue, 20 Aug 2002 09:19:15 +0100."
             <20020820091915.A16965@infradead.org> 
Date: Tue, 20 Aug 2002 20:25:53 +1000
Message-Id: <20020820185725.920DF2C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020820091915.A16965@infradead.org> you write:
> On Tue, Aug 20, 2002 at 02:39:57PM +1000, Rusty Russell wrote:
> > +   bool '  Probes' CONFIG_KPROBES
> 
> A little more descriptive options sounds like a good idea.. ;)

I couldn't really think of a better one.  Kernel Probes is kinda
redundant.  It's under kernel hacking, and it has a help option.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
