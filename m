Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbUKQM7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbUKQM7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUKQM7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:59:12 -0500
Received: from pop.gmx.net ([213.165.64.20]:1926 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262300AbUKQM7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:59:08 -0500
X-Authenticated: #4399952
Date: Wed, 17 Nov 2004 13:59:59 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: john cooper <john.cooper@timesys.com>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041117135959.23c98bf0@mango.fruits.de>
In-Reply-To: <20041117134150.GA29754@elte.hu>
References: <20041116223243.43feddf4@mango.fruits.de>
	<20041116224257.GB27550@elte.hu>
	<20041116230443.452497b9@mango.fruits.de>
	<20041116231145.GC31529@elte.hu>
	<20041116235535.6867290d@mango.fruits.de>
	<20041117002926.32a4b26f@mango.fruits.de>
	<419A961A.2070005@timesys.com>
	<20041117122318.479805fa@mango.fruits.de>
	<20041117130236.GA28240@elte.hu>
	<20041117131400.0c1dbe95@mango.fruits.de>
	<20041117134150.GA29754@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 14:41:50 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > > could you send me the latest .config you are using on this box?
> > 
> > sure. attached. 
> 
> > what else would be interesting for you?
> 
> have you kicked the latency tracer by clearing preempt_max_latency, or
> is it at the default (off) value?

I didn't touch it.

flo
