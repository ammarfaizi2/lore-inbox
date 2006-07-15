Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWGOCEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWGOCEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 22:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945974AbWGOCEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 22:04:24 -0400
Received: from www.osadl.org ([213.239.205.134]:36016 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1945972AbWGOCEX (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 14 Jul 2006 22:04:23 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Thomas Gleixner <tglx@linutronix.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: markh@compro.net, linux-kerneL@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1152916456.3119.92.camel@mindpipe>
References: <448876B9.9060906@compro.net>
	 <1152916456.3119.92.camel@mindpipe>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 15 Jul 2006 04:04:19 +0200
Message-Id: <1152929059.5915.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 18:34 -0400, Lee Revell wrote:
> On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
> > ftp://ftp.compro.net/public/rt-exec/
> 
> The high res timers do not seem to be working.  Using 2.6.17-rt3 and
> glibc 2.3.6, I get the exact same (bad) results whether
> CONFIG_HIGH_RES_TIMERS is enabled or not.

Can you please send me a boot log ?

	tglx


