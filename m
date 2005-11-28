Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVK1Wkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVK1Wkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVK1Wkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:40:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53473 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932258AbVK1Wkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:40:49 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051128160052.GA29540@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 17:40:50 -0500
Message-Id: <1133217651.4678.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 17:00 +0100, Ingo Molnar wrote:
> > On Mon, 2005-11-28 at 12:48 +0100, Ingo Molnar wrote:
> > > which was the last -rt kernel that worked fine for you in 
> > > PREEMPT_DESKTOP mode?
> > 

> > Would you like me to do a binary search?
> 
> that would certainly be very helpful!
> 

Well, 2.6.11-RT-V0.7.40-04 works...

Lee

