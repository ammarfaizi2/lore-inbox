Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263416AbUJ2QWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbUJ2QWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUJ2QRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:17:54 -0400
Received: from mail.gmx.de ([213.165.64.20]:45496 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263423AbUJ2QPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:15:50 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 18:32:56 +0200
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
Message-ID: <20041029183256.564897b2@mango.fruits.de>
In-Reply-To: <20041029161433.GA6717@elte.hu>
References: <20041029090957.GA1460@elte.hu>
	<200410291101.i9TB1uhp002490@localhost.localdomain>
	<20041029111408.GA28259@elte.hu>
	<20041029161433.GA6717@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 18:14:33 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> the BKL can generate arbitrary latencies. Anything up to 100-200
> milliseconds. Rui, Florian, could you try the quick hack below?

sure, with a fully REALTIME_PREEMPTION kernel?

flo
