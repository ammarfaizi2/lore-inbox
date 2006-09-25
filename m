Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWIYQMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWIYQMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWIYQMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:12:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5352 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751099AbWIYQMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:12:14 -0400
Date: Mon, 25 Sep 2006 09:12:15 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060925161215.GA19230@w-mikek2.ibm.com>
References: <20060920141907.GA30765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920141907.GA30765@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 04:19:07PM +0200, Ingo Molnar wrote:
> In particular, a nasty softirq performance bug has been fixed, which 
> caused the "5x slowdown under TCP" bug reported to lkml - those TCP 
> performance figures are now on par with vanilla performance.

Just curious about the cause and fix for this issue.  I tried searching
the mail lists for discussion but came up empty.  The patch it too big
for me to determine what specific changes addressed this issue.  If anyone
can point me in the right direction, that would be appreciated.

Thanks,
-- 
Mike
