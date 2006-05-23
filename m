Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWEWP0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWEWP0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWEWP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:26:34 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:44028 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751346AbWEWP0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:26:34 -0400
Subject: Re: RT patch + LTTng
From: Daniel Walker <dwalker@mvista.com>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605231657.45363.Serge.Noiraud@bull.net>
References: <200605221742.29566.Serge.Noiraud@bull.net>
	 <1148393197.3535.85.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <200605231657.45363.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=utf-8
Date: Tue, 23 May 2006 08:26:30 -0700
Message-Id: <1148397990.3535.87.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 16:57 +0200, Serge Noiraud wrote:
> mardi 23 Mai 2006 16:06, Daniel Walker wrote/a écrit :
> > On Mon, 2006-05-22 at 17:42 +0200, Serge Noiraud wrote:
> > 
> > > ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
> > > ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup <<...>-3> (0 0)
> > 
> > 
> > Do you also have preempt and interrupt latency turned on ? In addition
> > to wakeup latency ..
> Here is all I configured :


Do you get the same effect with all those options turned off?

Daniel

