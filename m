Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVJXTqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVJXTqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJXTqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:46:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:10398 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751244AbVJXTqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:46:43 -0400
Subject: Re: 2.6.14-rc4-rt7
From: john stultz <johnstul@us.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
In-Reply-To: <1130182717.4637.2.camel@cmn3.stanford.edu>
References: <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 12:46:38 -0700
Message-Id: <1130183199.27168.296.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 12:38 -0700, Fernando Lopez-Lezcano wrote:
> On Mon, 2005-10-24 at 12:28 -0700, Fernando Lopez-Lezcano wrote:
> > On Sat, 2005-10-22 at 05:58 +0200, Ingo Molnar wrote: 
> > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > 
> > > > Here's one with rc5-rt3:
> > 
> > rc5-rt5, _without_ HIGH_RES_TIMERS. 
> 
> Same warnings when booting into the UP kernel, so far no hang but I have
> not been logged in for long:

Can you send me a full dmesg?

thanks
-john


