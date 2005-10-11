Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVJKU4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVJKU4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVJKU4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:56:38 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:41144 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751071AbVJKU4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:56:37 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051011111454.GA15504@elte.hu>
References: <20051011111454.GA15504@elte.hu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 13:55:51 -0700
Message-Id: <1129064151.5324.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 13:14 +0200, Ingo Molnar wrote:
> i have released the 2.6.14-rc4-rt1 tree, which can be downloaded from 
> the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> lots of fixes all across the spectrum. x64 support and debugging 
> features on x64 should be in a much better shape now. Same for ARM.

Hi Ingo, just a heads up, I'm still seeing the same problems I reported
with rt13. After about 10 to 15 minutes of up time I see the usual
warnings from Jack, keyboard repeat problems (repeats keys too fast) and
random screensaver triggers. The last two seem to be "clustered" in
time, for a little while things work, then both happen and so on and so
forth. 

Sorry to not have any traces that could help, I'm still too busy to be
able to sit down quietly and gather data. 
-- Fernando


