Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbSKAIV0>; Fri, 1 Nov 2002 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265662AbSKAIV0>; Fri, 1 Nov 2002 03:21:26 -0500
Received: from dp.samba.org ([66.70.73.150]:10468 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265659AbSKAIVZ>;
	Fri, 1 Nov 2002 03:21:25 -0500
Date: Fri, 1 Nov 2002 19:23:39 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: hch@infradead.org, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-Id: <20021101192339.199c666b.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0210311659310.6949-100000@serv>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.44.0210311452531.13258-100000@serv>
	<20021031152710.A8214@infradead.org>
	<Pine.LNX.4.44.0210311659310.6949-100000@serv>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002 17:03:04 +0100 (CET)
Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Thu, 31 Oct 2002, Christoph Hellwig wrote:
> 
> > > Here a small howto for CML1 users.
> > 
> > Could you please update Documentation/kbuild/config-language.txt
> > based on that?
> 
> Actually I want to update it based on what's on my home page. I'll do it 
> very soon.

Doco is great, and it'd be nice to replace what's there, but I think it's
remarkably easy to use in a monkey-see-monkey-do fashion, which is *really*
good because that's how people will use it.

Plus, I never realized how slow the old "make oldconfig" was.

Thanks Roman!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
