Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTFKOdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTFKOdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:33:54 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:49642 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262135AbTFKOdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:33:52 -0400
Date: Wed, 11 Jun 2003 07:47:31 -0700
From: Larry McVoy <lm@bitmover.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK-CVS gateway] version tags
Message-ID: <20030611144731.GA20493@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306111641140.1602-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306111641140.1602-100000@neptune.local>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll go look.  CVS takes way too long to tag, it forces a rewrite of 
every file.  I did attempt to filter out tags that weren't of the forn
v2.* but it looks like I screwed up.  

On Wed, Jun 11, 2003 at 04:44:37PM +0200, Pascal Schmidt wrote:
> 
> Hi!
> 
> I noticed both the 2.4 and 2.5 BK->CVS trees don't have version tags
> any more (v2_5_70, for example, as in the old tree).
> 
> Is this intentional? Did CVS take too long to tag all files or something?
> 
> It was quite a nice feature to have them, very useful for finding out the
> differences between certain kernel versions. I can live without it, 
> though. It's still a nice service without the tags. (Thanks!)
> 
> -- 
> Ciao,
> Pascal

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
