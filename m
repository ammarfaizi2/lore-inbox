Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268500AbUHLKLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268500AbUHLKLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 06:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268504AbUHLKLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 06:11:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48272 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268500AbUHLKLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 06:11:49 -0400
Date: Thu, 12 Aug 2004 03:11:13 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-Id: <20040812031113.425004da.pj@sgi.com>
In-Reply-To: <20040812094837.GA3946@in.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040811131155.GA4239@in.ibm.com>
	<20040811091732.411edb6d.pj@sgi.com>
	<20040811180558.GA4066@in.ibm.com>
	<20040811134018.1551e03b.pj@sgi.com>
	<20040812094837.GA3946@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok revised patch attached

Sweet - thanks.  I have one other small patch against the
cpuset patch I posted on lkml a week ago I guess now.

Next week, I expect to repost, against a current *-mm,
and I will include your revised patch, after I build and
test it along with my stuff.  Thanks.

The rest of this week is taken up with unrelated duties
for me.


> applies only to the rest_init function which does not have
> the __init qualifier

Ok.

If you have any thoughts on the issue I raised at the end of
my previous message in this subthread, concerning numa policies
that get out of sync with their tasks cpuset, I'd be interested
to hear them.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
