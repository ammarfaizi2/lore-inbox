Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945976AbWGOCKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945976AbWGOCKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 22:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWGOCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 22:10:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19082 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1945976AbWGOCKa (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 14 Jul 2006 22:10:30 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: markh@compro.net, linux-kerneL@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1152929059.5915.11.camel@localhost>
References: <448876B9.9060906@compro.net>
	 <1152916456.3119.92.camel@mindpipe>  <1152929059.5915.11.camel@localhost>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 22:10:27 -0400
Message-Id: <1152929428.3119.114.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 04:04 +0200, Thomas Gleixner wrote:
> On Fri, 2006-07-14 at 18:34 -0400, Lee Revell wrote:
> > On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
> > > ftp://ftp.compro.net/public/rt-exec/
> > 
> > The high res timers do not seem to be working.  Using 2.6.17-rt3 and
> > glibc 2.3.6, I get the exact same (bad) results whether
> > CONFIG_HIGH_RES_TIMERS is enabled or not.
> 
> Can you please send me a boot log ?

Sent off-list.

Lee

