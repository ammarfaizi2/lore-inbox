Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbTIXDrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIXDrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:47:03 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19592 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261419AbTIXDq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:46:59 -0400
Date: Tue, 23 Sep 2003 20:45:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@suse.de>,
       andrea@kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924034552.GB7887@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@redhat.com>, Larry McVoy <lm@bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, andrea@kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
References: <20030924031602.GA7887@work.bitmover.com> <Pine.LNX.4.44.0309232327490.15940-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309232327490.15940-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:31:05PM -0400, Rik van Riel wrote:
> On Tue, 23 Sep 2003, Larry McVoy wrote:
> 
> > Yeah.  I'm using the Linux VM.  And it _still_ isn't up to what I managed
> > to accomplish in SunOS.  Wake up, dude.  You aren't the first one to
> > work in this area, you are just one of the first to work in this area
> > without learning from the people who came before you.  Don't believe me?
> > Go to OLS and read the papers.  Then read the OS research that has
> > happened in the last 20 years or so.  So far you are still catching up.
> 
> Bad example ;)
> 
> While it is true that the Linux VM doesn't do a whole
> lot of the things a VM should do, there is also the
> fact that the VM problem space has gotten a lot harder
> over the last decade due to the fact that the size of
> disk and memory has grown way faster than the speed of
> disk and memory.

Oh, I agree.  The problem space changes and you have to move with it.  
I was just pointing out that by not learning from others you put yourself
at a disadvantage.  There are a lot of bright minds in the Linux space,
there is no question of that.  But they would do so much better if they
understood the past.  The past holds a lot of information, ignoring it
is a disadvantage.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
