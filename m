Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbSKOVQM>; Fri, 15 Nov 2002 16:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSKOVQM>; Fri, 15 Nov 2002 16:16:12 -0500
Received: from bitmover.com ([192.132.92.2]:2728 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266726AbSKOVQL>;
	Fri, 15 Nov 2002 16:16:11 -0500
Date: Fri, 15 Nov 2002 13:23:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021115132304.M19291@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]> <1037395835.22209.3.camel@rth.ninka.net> <336460000.1037398316@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <336460000.1037398316@flay>; from mbligh@aracnet.com on Fri, Nov 15, 2002 at 02:11:56PM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, but look at the flip side ... once that bug has been logged
> in bugzilla, the person who would have emailed lkml now has an easily
> searchable interface, and could have found the bug, found out what the
> patch for it was, and fixed it themselves, without ever bothering you,
> lkml, or anyone. I'm not saying that'll happen 100% of the time, but 
> it should help overall ... will just take a short period whilst data 
> builds up.

Too much data and the data becomes noise.

I also think that if your goal is to make things progress more smoothly,
adding work for people like dave is not a good plan.

This is not an easy problem space, on the one hand you want to have all
bugs tracked, on the other hand, trivial bugs in the bug db just make
the bug db unusable.  No engineer is going to put up with 100,000 stupid
bug reports.  You need a plan to get rid of those or keep them out of 
the bugdb or it's unlikely to get used by the people who really need to
use it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
