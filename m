Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbSKOV22>; Fri, 15 Nov 2002 16:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbSKOV22>; Fri, 15 Nov 2002 16:28:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47833 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266754AbSKOV22>;
	Fri, 15 Nov 2002 16:28:28 -0500
Date: Fri, 15 Nov 2002 13:33:19 -0800 (PST)
Message-Id: <20021115.133319.89269342.davem@redhat.com>
To: lm@bitmover.com
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021115132304.M19291@work.bitmover.com>
References: <1037395835.22209.3.camel@rth.ninka.net>
	<336460000.1037398316@flay>
	<20021115132304.M19291@work.bitmover.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Fri, 15 Nov 2002 13:23:04 -0800
   
   This is not an easy problem space, on the one hand you want to have all
   bugs tracked, on the other hand, trivial bugs in the bug db just make
   the bug db unusable.  No engineer is going to put up with 100,000 stupid
   bug reports.  You need a plan to get rid of those or keep them out of 
   the bugdb or it's unlikely to get used by the people who really need to
   use it.

Exactly.

It seems to me that only allowing one person to close a bug is going
to be the big bottleneck in a project like this.  There is no reason
the community cannot close the bugs.

It isn't going to scale if it's just one person per category.  That
simply won't work.

So with that taken care of, basically the database begins to
degenerate into a copy of linux-kernel with a nicer search engine :-)
