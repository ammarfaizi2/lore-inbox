Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTDHRvo (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDHRvn (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:51:43 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:11932 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261966AbTDHRvm (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:51:42 -0400
Date: Tue, 8 Apr 2003 11:02:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030408180225.GC27912@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304081354_MC3-1-3386-1A33@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304081354_MC3-1-3386-1A33@compuserve.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 01:52:01PM -0400, Chuck Ebbert wrote:
> >>   1. Keep the csets separate but link them together.  Let the developer
> >>      tell the system whether one is an enhancement or a bugfix to the base.
> >
> > BK already does this.
> 
> Can I somehow 'collapse' the csets together when browsing the repository?
> A nice example might be the recent ethernet padding fix, where there ended
> up being a whole set of separate patches.  By looking through the
> comments I can piece together a complete patch, but it's painful.

Yup, but not in a released version (we have an enormous pile of changes
we haven't released because they aren't fully cooked or we aren't sure
that we like them or we're worried about the open source guys stealing
them).  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
