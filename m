Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbUJYNg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUJYNg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUJYNeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:34:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:19681 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261799AbUJYNcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:32:19 -0400
X-Authenticated: #4399952
Date: Mon, 25 Oct 2004 15:48:55 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025154855.21447333@mango.fruits.de>
In-Reply-To: <20041025153940.1de340b4@mango.fruits.de>
References: <20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<20041022133551.GA6954@elte.hu>
	<20041022155048.GA16240@elte.hu>
	<20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<417CDE90.6040201@cybsft.com>
	<20041025111046.GA3630@elte.hu>
	<20041025121210.GA6555@elte.hu>
	<20041025153940.1de340b4@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 15:39:40 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Mon, 25 Oct 2004 14:12:10 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i think i found the bug - now selinux boots fine. I've uploaded -V0.1
> > with the fix included. This fix could solve a number of other complaints
> > as well.
> 
> some more:

[snip]

i forgot to mention these were from the same session as the previous one.
also i think i missed the first ones, so the reports in this mail are
probably useless(?).

flo
