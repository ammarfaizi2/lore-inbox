Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271068AbUKARLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271068AbUKARLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S279630AbUKARLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:11:09 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:29484 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S271275AbUKARFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:05:02 -0500
Message-ID: <32917.192.168.1.5.1099328648.squirrel@192.168.1.5>
In-Reply-To: <20041101140630.GA20448@elte.hu>
References: <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu>
    <1099227269.1459.45.camel@krustophenia.net>
    <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
    <20041031162059.1a3dd9eb@mango.fruits.de>
    <20041031165913.2d0ad21e@mango.fruits.de>
    <20041031200621.212ee044@mango.fruits.de>
    <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu>
    <20041101140630.GA20448@elte.hu>
Date: Mon, 1 Nov 2004 17:04:08 -0000 (WET)
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Paul Davis" <paul@linuxaudiosystems.com>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "LKML" <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "jackit-devel" <jackit-devel@lists.sourceforge.net>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Nov 2004 17:04:46.0829 (UTC) FILETIME=[E3F149D0:01C4C034]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> I've uploaded -V0.6.5 to the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>

Build error:

kernel/built-in.o(.text+0x308a): In function `show_state':
: undefined reference to `show_all_locks'
kernel/built-in.o(.text+0x30bc): In function `show_state':
: undefined reference to `show_all_locks'
make: *** [.tmp_vmlinux1] Error 1

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

