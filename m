Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267804AbTBVAGo>; Fri, 21 Feb 2003 19:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTBVAGo>; Fri, 21 Feb 2003 19:06:44 -0500
Received: from bitmover.com ([192.132.92.2]:14487 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267804AbTBVAGn>;
	Fri, 21 Feb 2003 19:06:43 -0500
Date: Fri, 21 Feb 2003 16:16:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222001618.GA19700@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96700000.1045871294@w-hlinder>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Ben said none of the distros are supporting these large 
> systems right now. Martin said UL is already starting to support
> them. 

Ben is right.  I think IBM and the other big iron companies would be
far better served looking at what they have done with running multiple
instances of Linux on one big machine, like the 390 work.  Figure out
how to use that model to scale up.  There is simply not a big enough
market to justify shoveling lots of scaling stuff in for huge machines
that only a handful of people can afford.  That's the same path which
has sunk all the workstation companies, they all have bloated OS's and
Linux runs circles around them.

In terms of the money and in terms of installed seats, the small Linux
machines out number the 4 or more CPU SMP machines easily 10,000:1.
And with the embedded market being one of the few real money makers
for Linux, there will be huge pushback from those companies against
changes which increase memory footprint.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
