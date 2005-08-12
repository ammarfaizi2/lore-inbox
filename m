Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVHLHsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVHLHsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVHLHsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:48:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:40587
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751150AbVHLHsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:48:52 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
	Resolution Timers & RCU-tasklist features
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
In-Reply-To: <1123816760.4453.10.camel@mindpipe>
References: <20050811110051.GA20872@elte.hu>
	 <1123816044.4453.7.camel@mindpipe>  <1123816760.4453.10.camel@mindpipe>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 12 Aug 2005 07:48:42 +0000
Message-Id: <1123832922.23647.81.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 23:19 -0400, Lee Revell wrote:
> On Thu, 2005-08-11 at 23:07 -0400, Lee Revell wrote:
> > Very nice to see this going in (via) the RT patch.
> > 
> 
> Also, does not compile for me with ACPI PM timer selected:

I did not come around yet to adapt the PM timer to the overall changes I
made.

tglx


