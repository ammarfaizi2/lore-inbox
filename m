Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWGUSRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWGUSRZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 14:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWGUSRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 14:17:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11479 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751099AbWGUSRZ (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 21 Jul 2006 14:17:25 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Lee Revell <rlrevell@joe-job.com>
To: markh@compro.net
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kerneL@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <44BB9CC1.5060105@compro.net>
References: <448876B9.9060906@compro.net>
	 <1152916456.3119.92.camel@mindpipe>  <1152929059.5915.11.camel@localhost>
	 <1152929428.3119.114.camel@mindpipe>  <44BB9CC1.5060105@compro.net>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 14:17:41 -0400
Message-Id: <1153505861.16617.203.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 10:20 -0400, Mark Hounschell wrote:
> Lee Revell wrote:
> > On Sat, 2006-07-15 at 04:04 +0200, Thomas Gleixner wrote:
> >> On Fri, 2006-07-14 at 18:34 -0400, Lee Revell wrote:
> >>> On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
> >>>> ftp://ftp.compro.net/public/rt-exec/
> >>> The high res timers do not seem to be working.  Using 2.6.17-rt3 and
> >>> glibc 2.3.6, I get the exact same (bad) results whether
> >>> CONFIG_HIGH_RES_TIMERS is enabled or not.
> >> Can you please send me a boot log ?
> > 
> > Sent off-list.
> > 
> > Lee
> > 
> > 
> 
> Did you get this sorted out?

No.  Thomas, were you able to test my .config?

Lee

