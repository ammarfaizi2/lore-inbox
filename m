Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263358AbUJ2RDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbUJ2RDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbUJ2RDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:03:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:11999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263433AbUJ2Q7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:59:46 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 19:16:52 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029191652.1e480e2d@mango.fruits.de>
In-Reply-To: <20041029163155.GA9005@elte.hu>
References: <20041029090957.GA1460@elte.hu>
	<200410291101.i9TB1uhp002490@localhost.localdomain>
	<20041029111408.GA28259@elte.hu>
	<20041029161433.GA6717@elte.hu>
	<20041029183256.564897b2@mango.fruits.de>
	<20041029162316.GA7743@elte.hu>
	<20041029163155.GA9005@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 18:31:55 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > > the BKL can generate arbitrary latencies. Anything up to 100-200
> > > > milliseconds. Rui, Florian, could you try the quick hack below?
> > > 
> > > sure, with a fully REALTIME_PREEMPTION kernel?
> > 
> > correct, and with the changeall-tree hack in addition. And keep your
> > finger near the reset button, just in case ...
> 
> it wont even boot ...
> 
> let me try some more hacks to make this a little bit safer.

hehe, it even booted for me [kinda]. will build the one where you got xmms
to run. but i will sure as hell hit "get new emails" during the build more
than once ;)

flo
