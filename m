Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTIYSiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIYSiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:38:09 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:61583 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261689AbTIYSiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:38:06 -0400
Date: Thu, 25 Sep 2003 11:36:23 -0700
From: Larry McVoy <lm@bitmover.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925183623.GC18749@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, andrea@kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org> <20030925182233.GA1356@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925182233.GA1356@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 08:22:33PM +0200, J?rn Engel wrote:
> Would be nice, if Larry coded up something central that all projects
> could benefit from, but that is not necessary.  

Is the "bkbits.net can export any patch and/or version of a tree as plain
text" match what you are asking for or not?

So if there was a URL that you could type in that fed you the patch as
plain text, with any associated checkin comments, is that what you meant?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
