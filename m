Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTIAQhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTIAQhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:37:19 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:56043 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263077AbTIAQhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:37:10 -0400
Date: Mon, 1 Sep 2003 09:36:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Christoph Hellwig <hch@infradead.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de
Subject: Re: bitkeeper comments
Message-ID: <20030901163657.GF1327@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, ak@suse.de
References: <1062389729.314.31.camel@cube> <20030901140706.GG18458@work.bitmover.com> <1062430014.314.59.camel@cube> <20030901154646.GB1327@work.bitmover.com> <20030901165658.A24661@infradead.org> <20030901155915.GC1327@work.bitmover.com> <1062434020.14183.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062434020.14183.13.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 05:33:40PM +0100, Alan Cox wrote:
> On Llu, 2003-09-01 at 16:59, Larry McVoy wrote:
> > Hey, I'm not in the middle of this because I don't understand who is right
> > and it's not my place to make that call.  I said "if Linus or Marcelo says
> > do it"  specifically for the case that there is some hanky panky going on.
> > On the other hand, it's perfectly possible that the wrong comment got 
> > stuck in there and if that's the case why shouldn't it get fixed?
> 
> Presumably in the abstract "if you care" case you can generate this
> change globally by excluding that changeset and all after, then
> reapplying it with a different comment then reapplying all that follow ?

Yup, that would work just fine.  Anyone can do this.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
