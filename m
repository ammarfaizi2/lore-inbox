Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbULZCVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbULZCVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 21:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULZCVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 21:21:41 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:8410 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261183AbULZCVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 21:21:40 -0500
Date: Sat, 25 Dec 2004 18:21:35 -0800
From: Larry McVoy <lm@bitmover.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: lease.openlogging.org is unreachable
Message-ID: <20041226022135.GA3250@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412250121_MC3-1-91AF-7FBB@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 01:20:34AM -0500, Chuck Ebbert wrote:
> lease.openlogging.org is unreachable today.
> 
> So I guess I need to set up a cron job to renew my lease every
> minute/hour/day/whatever so I can actually download new kernel
> releases when they come out?  I can't even examine the code I
> downloaded yesterday without that lease...  Now that's what I call
> having my source code held hostage!

It's back up.  Go to a repo and say "bk lease renew" and you should be
all set.  
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
