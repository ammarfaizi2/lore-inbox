Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271718AbTHHRTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271702AbTHHRTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:19:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:27272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271718AbTHHRTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:19:04 -0400
Date: Fri, 8 Aug 2003 10:18:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Timothy Miller <miller@techsource.com>
cc: Jasper Spaans <jasper@vs19.net>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
In-Reply-To: <3F33BF33.8070601@techsource.com>
Message-ID: <Pine.LNX.4.44.0308081011550.27922-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Aug 2003, Timothy Miller wrote:
>
> > 1357:	rpc_authflavor_t authflavour;

This one I think is valid. Considering how many people seem to care, I 
think we should keep it as the only valid case for now.

> Yes, when it comes to spelling of words in variable and type names, I 
> think it would be a good idea to be consistent.
> 
> What is Linus's preferred spelling?  Let's use that.

I don't much care. I was taught English spelling in school, and I've 
gotten used to US spelling here.

I think you guys who care should have a huge free-for-all, an electronic
mud-wrestling thing if you will. But not on linux-kernel. 

I can see it now:

   ".. Alan Cox gets up, and tackles Zwane, who goes down in the mud.  
    Oops.  They were on the same side. I guess Alan got caught up in the
    rush.  Jasper tries to take advantage of the situation, but slips in
    the mud, and goes down in a heap with Alexander..."

Tell me when it's over.

		Linus


