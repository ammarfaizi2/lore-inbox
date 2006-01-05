Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWAEU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWAEU6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWAEU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:58:42 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:26177 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750864AbWAEU6l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:58:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GF5akc+Fb4eFeg3BmhTCAGbQjRmJE0rTk25ejdVaQwLdO435clVx7WDSs3A1d+K6RslNhCWHDC9dvPb9KxixJX1KbwWE/lEOlB8aA5fFwslEYnHKUUVwk0ebRW6iigqPPxW44K/Iv8HpVQyNZJXquhGUtlMn/7USWPKmZiRhMEQ=
Message-ID: <5bdc1c8b0601051258j3bfc390bsa770ddf6506d2deb@mail.gmail.com>
Date: Thu, 5 Jan 2006 12:58:39 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc7-rt1
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1136492165.847.9.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228172643.GA26741@elte.hu>
	 <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
	 <1136051113.6039.109.camel@localhost.localdomain>
	 <1136054936.6039.125.camel@localhost.localdomain>
	 <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
	 <1136205719.6039.156.camel@localhost.localdomain>
	 <5bdc1c8b0601051133g6ed0b3b4ob699d65e4a12b699@mail.gmail.com>
	 <1136492165.847.9.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2006-01-05 at 11:33 -0800, Mark Knecht wrote:
> > I expect that I am probably still getting a low level of xruns. I
> > hope one day we can make that work a bit better.
>
> Were you ever able to get latency tracing to work on your box?
>
> Lee

Not yet, due to the power failure and being off line. I'll give it a
shot this evening.

Does anyone with an AMD64 platform have this working?

Thanks,
Mark
