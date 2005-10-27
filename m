Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVJ0AMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVJ0AMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVJ0AME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:12:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:43158 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932309AbVJ0AMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:12:01 -0400
Subject: Re: 2.6.14-rc4-rt7
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: William Weston <weston@lysdexia.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <1130371106.21118.78.camel@localhost.localdomain>
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
	 <1130371106.21118.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 17:11:56 -0700
Message-Id: <1130371917.27168.359.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 19:58 -0400, Steven Rostedt wrote:
> On Wed, 2005-10-26 at 16:33 -0700, john stultz wrote:
> 
> > I'm grabbing rt7 to try to reproduce this. Not yet sure what the cause
> > could be. From Rui's dmesg the tsc clocksource was being used, I assume
> > this is the case with you as well, William?
> 
> John (and/or Ingo and Thomas),
> 
> Does -rt7 have your latest code?

Not quite my latest, but rt7 does have B8 or better.

thanks
-john


