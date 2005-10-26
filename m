Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbVJZX65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbVJZX65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 19:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVJZX65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 19:58:57 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7612 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751507AbVJZX64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 19:58:56 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: William Weston <weston@lysdexia.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <1130369591.27168.358.camel@cog.beaverton.ibm.com>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
	 <1130369591.27168.358.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 26 Oct 2005 19:58:26 -0400
Message-Id: <1130371106.21118.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 16:33 -0700, john stultz wrote:

> I'm grabbing rt7 to try to reproduce this. Not yet sure what the cause
> could be. From Rui's dmesg the tsc clocksource was being used, I assume
> this is the case with you as well, William?

John (and/or Ingo and Thomas),

Does -rt7 have your latest code?

-- Steve


