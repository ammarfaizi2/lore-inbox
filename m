Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbUKPP2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbUKPP2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUKPP2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:28:42 -0500
Received: from pop.gmx.net ([213.165.64.20]:1207 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262013AbUKPP2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:28:40 -0500
X-Authenticated: #4399952
Date: Tue, 16 Nov 2004 16:29:24 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116162924.2ee20f4d@mango.fruits.de>
In-Reply-To: <20041116160822.6a845755@mango.fruits.de>
References: <20041027001542.GA29295@elte.hu>
	<20041103105840.GA3992@elte.hu>
	<20041106155720.GA14950@elte.hu>
	<20041108091619.GA9897@elte.hu>
	<20041108165718.GA7741@elte.hu>
	<20041109160544.GA28242@elte.hu>
	<20041111144414.GA8881@elte.hu>
	<20041111215122.GA5885@elte.hu>
	<20041116125402.GA9258@elte.hu>
	<20041116130946.GA11053@elte.hu>
	<20041116134027.GA13360@elte.hu>
	<20041116152021.79409166@mango.fruits.de>
	<20041116160822.6a845755@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 16:08:22 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Tue, 16 Nov 2004 15:20:21 +0100
> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > i built a 27-4 kernel and tried to boot into it. It hangs after:
> > 
> > Uncompressing linux.. Ok, booting the kernel
> > 
> > Will try plain 2.6.10-rc2-mm1 and 2.6.10-rc2
> > 
> > .config is here:
> > 
> > http://affenbande.org/~tapas/config
> 
> Ok, both 2.6.10-rc2 and 2.6.10-rc2-mm1 boot fine.. Rebuilding 27-4 kernel to
> see if i can still reproduce above mentioned hang..

ok, this new build still hangs at the same spot.

flo
