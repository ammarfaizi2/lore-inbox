Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271369AbTHDDtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 23:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271371AbTHDDtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 23:49:05 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:407 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S271369AbTHDDtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 23:49:03 -0400
Date: Sun, 3 Aug 2003 20:48:43 -0700
From: Larry McVoy <lm@bitmover.com>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030804034843.GA8683@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Glen Turner <glen.turner@aarnet.edu.au>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <3F2CAE61.7070401@pobox.com> <3F2DBB2B.9050803@aarnet.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2DBB2B.9050803@aarnet.edu.au>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 11:17:23AM +0930, Glen Turner wrote:
> >Really fast, really long pipes in practice don't exist for 99.9% of all 
> >Internet users.
> 
> Here every worthwhile fast pipe is a long fast pipe.  90% of
> Australia's net traffic goes to the West Coast of the USA,
> that's 14,000Km away.

I couldn't tell from your posting if you were arguing for an offload or not.
If you are, and you are using these stats as a reason, I'd like to know 
the absolute numbers, router to router, that we are talking about.  I have
a feeling that few cheap PC's could handle all the load but I'm willing 
to be educated.

Even if I'm way off, a pair of routers between Australia and the US is 
hardly a reason to muck about in the TCP stack.  If we were talking 
about millions of routers, well sure, that makes sense.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
