Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUEWVzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUEWVzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUEWVzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:55:24 -0400
Received: from web90008.mail.scd.yahoo.com ([66.218.94.66]:3992 "HELO
	web90008.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S263656AbUEWVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:55:20 -0400
Message-ID: <20040523215519.48712.qmail@web90008.mail.scd.yahoo.com>
Date: Sun, 23 May 2004 14:55:19 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: 4g/4g for 2.6.6
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So do I understand this correctly, in 2.6.7(+) it will
no longer be necessary to have the 4g patches?  I will
be able to get 4g/process with the going forward
kernels?

Thank you for your time.
Phy

--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Sun, 23 May 2004, Phy Prabab wrote:
> > 
> > I have been researching the 4g patches for
> kernels. 
> > Seems there was a rift between people over this. 
> Is
> > there any plan to resume publishing 4g patches for
> > developing kernels?
> 
> Quite frankly, a number of us are hoping that we can
> make them
> unnecessary. The cost of the 4g/4g split is
> absolutely _huge_ on some
> things, including basic stuff like kernel compiles.
> 
> The only valid reason for the 4g split is that the
> VM doesn't always 
> behave well with huge amounts of highmem. The
> anonvma stuff in 2.6.7-pre1 
> is hoped to make that much less of an issue.
> 
> Personally, if we never need to merge 4g for real,
> I'll be really really 
> happy. I see it as a huge ugly hack.
> 
> 			Linus



	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
