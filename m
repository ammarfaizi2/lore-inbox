Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTGXVmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271741AbTGXVmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 17:42:45 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:6357 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S271740AbTGXVmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 17:42:44 -0400
Date: Thu, 24 Jul 2003 14:57:44 -0700
From: Larry McVoy <lm@bitmover.com>
To: Leandro Guimar?es Faria Corsetti Dutra <lgcdutra@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Switching to the OSL License, in a dual way.
Message-ID: <20030724215744.GA7777@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Leandro Guimar?es Faria Corsetti Dutra <lgcdutra@terra.com.br>,
	linux-kernel@vger.kernel.org
References: <pan.2003.07.24.18.06.06.546220@terra.com.br> <Pine.LNX.4.10.10307241256360.16098-100000@master.linux-ide.org> <pan.2003.07.24.21.05.40.969654@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.07.24.21.05.40.969654@terra.com.br>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 11:05:40PM +0200, Leandro Guimar?es Faria Corsetti Dutra wrote:
> > For those who can not (will not) read, clearly the suggestion for somebody
> > to take up the cause to develop a "Bitkeeper" clone.  Know the details of
> > the license it was issued to the community to use.
> 
> 	I can't quite see your point... what's the problem with a
> clone?  It certainly isn't immoral or illegal.  

A clone is illegal because you'd have to reverse engineer to do the clone
and reverse engineering is allowed for the purpose of interoperability,
not for the purpose of making a clone.  I suspect that the reverse
engineering exceptions were put in place to make sure that vendors
couldn't lockin their customers with no recourse for the customers.
In other words, your data is your data no matter where you store it.
Perfectly reasonable sentiment.

BK already provides more than enough in the way of interoperability,
both on the way in and on the way out.  It's trivial to get your 
data out of BK as well as your metadata.  It's a small perl script
to get all the info out and plop it into some other system, we're
much better about that than any free or commercial system.

In other words, reverse engineering is ok if the product doesn't
provide access to your data, we do that already, poof, no reverse
engineering allowed.  So it's illegal to reverse engineer BK.  

Given that, you can see why some people are disgusted that RMS would
suggest it is OK to clone BK.  At that point, it becomes a statement of
"it's OK to do illegal stuff if you are making GPLed software".  

Hardly the sort of thing you want on record in a public forum from a
free software leader when people are starting to question whether or
not the free software they have is actually legal.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
