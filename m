Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUKUOuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUKUOuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 09:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUKUOuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 09:50:18 -0500
Received: from imap.gmx.net ([213.165.64.20]:35493 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261199AbUKUOuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 09:50:07 -0500
X-Authenticated: #4399952
Date: Sun, 21 Nov 2004 15:50:53 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121155053.6c0b2305@mango.fruits.de>
In-Reply-To: <20041121125023.GC7972@elte.hu>
References: <20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<1100920963.1424.1.camel@krustophenia.net>
	<20041120125536.GC8091@elte.hu>
	<1100971141.6879.18.camel@krustophenia.net>
	<20041120191403.GA16262@elte.hu>
	<1100975745.6879.35.camel@krustophenia.net>
	<20041120201155.6dc43c39@mango.fruits.de>
	<20041120214035.2deceaeb@mango.fruits.de>
	<20041121125023.GC7972@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004 13:50:23 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > So i don't really know how to go about this. [...]
> 
> you could try to use user-triggered tracing to capture a trace of one
> such longer delay.

Ok, will do (searching relevant email).

flo
