Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTA1JHG>; Tue, 28 Jan 2003 04:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTA1JHF>; Tue, 28 Jan 2003 04:07:05 -0500
Received: from dp.samba.org ([66.70.73.150]:34539 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261290AbTA1JHF>;
	Tue, 28 Jan 2003 04:07:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] new modversions implementation 
In-reply-to: Your message of "Sat, 25 Jan 2003 20:30:44 MDT."
             <Pine.LNX.4.44.0301252025350.6749-100000@chaos.physics.uiowa.edu> 
Date: Tue, 28 Jan 2003 18:07:57 +1100
Message-Id: <20030128091625.2B5322C08A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301252025350.6749-100000@chaos.physics.uiowa.edu> yo
u write:
> On Sat, 25 Jan 2003, Sam Ravnborg wrote:
> 
> > A genksyms replacement should do all the three steps above?
> 
> Yes, I think at some point I should take a look at patching genksyms so 
> that the post-processing above is not necessary anymore. However, it 
> doesn't hurt much, performance-wise.

Of course, genksyms belongs in the kernel sources, too, since it's
intimately tied to them.

One step at a time...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
