Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbTJEN4h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 09:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTJEN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 09:56:37 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:7629 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S263109AbTJEN4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 09:56:36 -0400
Date: Sun, 5 Oct 2003 06:56:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Rob Landley <rob@landley.net>, andersen@codepoet.org,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031005135603.GA10245@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Rob Landley <rob@landley.net>, andersen@codepoet.org,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030914064144.GA20689@codepoet.org> <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org> <200310041952.09186.rob@landley.net> <20031005010521.GA21138@work.bitmover.com> <20031005023428.GI7665@parcelfarce.linux.theplanet.co.uk> <20031005034533.GA29679@work.bitmover.com> <1065349476.3157.10.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065349476.3157.10.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 11:24:36AM +0100, David Woodhouse wrote:
> On Sat, 2003-10-04 at 20:45 -0700, Larry McVoy wrote:
> > People get all worked up over this but when they do then they should
> > also claim that system calls are not a boundary either.
> 
> The first paragraph of the COPYING file makes it entirely clear that
> system calls were not considered to be such a boundary.

You're forgetting that what the GPL says doesn't matter if it is
unenforceable.  Remember all the people yelling at me that they can
reverse engineer BK in spite of any no-reverse-engineering clauses?
That same logic applies to the GPL, you can't have it both ways.

It doesn't matter what you think, or I think, or Linus thinks.  What
matters is what is legal and what isn't.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
