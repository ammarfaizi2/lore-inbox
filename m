Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272683AbTG3Heo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272795AbTG3Heo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:34:44 -0400
Received: from web20506.mail.yahoo.com ([216.136.226.141]:46184 "HELO
	web20506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272683AbTG3Hem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:34:42 -0400
Message-ID: <20030730073441.61933.qmail@web20506.mail.yahoo.com>
Date: Wed, 30 Jul 2003 00:34:41 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: linux-2.6.0-test1 : modules not working
To: Alex Goddard <agoddard@purdue.edu>
Cc: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0307300223300.4665@dust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am curious that linux-2.6.0-test1 supports external
modules yet or not ?

Thanks.

--- Alex Goddard <agoddard@purdue.edu> wrote:
> On Tue, 29 Jul 2003, Studying MTD wrote:
> 
> > I tried hello world example from
> > http://lwn.net/Articles/21817/
> > 
> > but i am still getting :-
> > 
> > #insmod hello_module.o
> > No module found in object
> > Error inserting 'hello_module.o': -1 Invalid
> module
> > format
> 
> [Snip]
> 
> 'kay.  So modules are enabled and everything.  More
> specifically, I was 
> after information such as the gcc options and stuff
> you used to compile 
> hello_module.o
> 
> Check the second article at that URL, and try
> building your hello_module
> with the basic Makefile it gives.  That uses the
> best way for building
> external modules.  After building your kernel that
> way, try inserting the
> hello_module.ko.
> 
> -- 
> Alex Goddard
> agoddard@purdue.edu
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
