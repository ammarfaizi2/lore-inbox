Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbTFBCIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 22:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbTFBCIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 22:08:12 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19667 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264803AbTFBCIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 22:08:11 -0400
Date: Sun, 1 Jun 2003 19:21:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030602022130.GA22771@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054519757.161606@palladium.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >which is why I've always preferred
> >
> >int
> >foo(void)
> >{
> >	/* body here */
> >}	
> 
> That makes no sense.

Whatever, it's your tree.  I'd rather have you force everything to the same
style, any style, than tolerate all sorts of different styles.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
