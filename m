Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWIVONH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWIVONH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWIVONH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:13:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12732 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932517AbWIVONG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:13:06 -0400
Subject: Re: 2.6.18-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <5bdc1c8b0609201238te67affcne7bb21d50bda3a69@mail.gmail.com>
References: <20060920141907.GA30765@elte.hu>
	 <5bdc1c8b0609201238te67affcne7bb21d50bda3a69@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 10:14:25 -0400
Message-Id: <1158934466.1097.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 12:38 -0700, Mark Knecht wrote:
> On 9/20/06, Ingo Molnar <mingo@elte.hu> wrote:
> > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded
> > from the usual place:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
> >
> 
> Hi Ingo,
>    I gave 2.6.18-rt2 a quick try. It compiled fine but crashed on
> boot. I've no way to copy the screen. I can send along a digital photo
> if the following isn't enough info.
> 
> QUESTION: Should I be able to run ati-drivers-8.28.8 with this kernel
> or would I have to wait for ATI to put out a 2.6.18 compatible driver?
> The current version does not emerge with 2.6.18-rt2.
> 

I would not expect any proprietary ATI driver to work with an -rt
kernel, unless they specifically release a binary for -rt.

> Not sure how much that will help you. Been awhile since I've sent
> along crash reports. I'll have to ge a second Linux machine running to
> do the console boot capture thing if you need it.

Try -rt3.  If the crash persists, you could take a picture of the screen
with a digital camera and post a link to it.

Lee


