Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTIYSuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTIYSuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:50:39 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:53136 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261695AbTIYSua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:50:30 -0400
Date: Thu, 25 Sep 2003 11:49:06 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925184906.GD18749@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org> <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:
> In addition there are some major gains to be had in standardizing on a
> distributed version control system that everyone can use, and
> unfortunately BK does not fill that position.  So I think it is good
> that there is enough general discontent it the air that people
> continue to look for alternatives. 

Let's just postulate that my claim that this is harder than it looks is
true.  You don't have to agree with it, just pretend you do.  Given that,
it's going to be a while before any alternative shows up.  People mumble
about arch until they go use it for a while and realize it is about 3-5
years behind BK.  Linus isn't about to step backwards that far.

> The current situation with version control is painful.  

No kidding.  Do you have any suggestions, _realistic_ suggestions, that 
we could do to help?  Beyond making plain text patches/tarballs available
from every repo hosted on bkbits?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
