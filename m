Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbTDIBZ3 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTDIBZ3 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:25:29 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:10170 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262663AbTDIBZ1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 21:25:27 -0400
Date: Tue, 8 Apr 2003 18:37:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.5 io statistics?
Message-ID: <20030409013700.GA4650@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@digeo.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
References: <20030408155858.GB27912@work.bitmover.com> <20030408152215.00b7beca.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408152215.00b7beca.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
> > 0.00  19M 562M  48M 4.0K   12K   0   0   0   0  137   25  267   83    0   0 100
> 
> It's currently undergoing a bit of change.

Well, one question is this: I'd like to be able to get at a list of disk stats
sorted by activity.  If you noticed, the output above reserved space for 4
drives.  I know it's not general at all, but it would be nice to somehow be
able to get at the "busy" drives.  I don't have any ideas on how to do this
generally and that might mean it isn't possible but maybe (I hope) it means
I'm tired and not thinking clearly.  Anyone have any ideas?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
