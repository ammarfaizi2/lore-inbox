Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVEVQ5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVEVQ5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 12:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVEVQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 12:57:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:26010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261831AbVEVQ5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 12:57:40 -0400
Date: Sun, 22 May 2005 09:59:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO
 chip
In-Reply-To: <1116763033.19183.14.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
 <1116763033.19183.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 May 2005, David Woodhouse wrote:
> 
> Linus, please do not apply patches from me which have my personal
> information mangled or removed.

I've asked Russell not to do it, but the fact is, he's worried about legal 
issues, and while I've also tried to resolve those (by having the OSDL 
lawyer try to contact some lawyers in the UK), that hasn't been clarified 
yet.

So either rmk needs to stop worrying about UK legal issues (the law itself 
sounds fine, but the stupidity is in potential interpretations of it, and 
I'm hoping we can get a statement saying that such an interpretation is 
not actually valid), or rmk would need to special-case you and others that 
explicitly ask him not to mangle sign-offs.

Now, having myself aggressively automated a lot of what I do just to be 
able to keep up, I have to admit that I understand rmk's objections to 
special-casing certain email addresses very well. It tends to just not be 
worth the pain.

So for now, it looks like we either have to make sure that rmk is 
comfortable with not editing sign-off's (working on it, but I can't 
guarantee anything), or that you're ok with getting the email stripped, 
_or_ you will end up having to send patches directly to me rather than to 
rmk (and face the chaos and bumbling that is Linus).

		Linus
