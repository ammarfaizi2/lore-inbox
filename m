Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263433AbUJ2R0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263433AbUJ2R0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ2RYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:24:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34538 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263433AbUJ2RVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:21:39 -0400
Date: Fri, 29 Oct 2004 19:22:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
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
Message-ID: <20041029172243.GA19630@elte.hu>
References: <20041029111408.GA28259@elte.hu> <20041029161433.GA6717@elte.hu> <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu> <20041029163155.GA9005@elte.hu> <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu> <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029172151.GB16276@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> >   CC      fs/ioctl.o
> > fs/ioctl.c: In function `sys_ioctl':
> > fs/ioctl.c:75: error: structure has no member named `ioctl_nobkl'
> > fs/ioctl.c:76: error: structure has no member named `ioctl_nobkl'
> 
> fs.h chunk went missing ... uploading -V0.5.14 in a minute.

done.

	Ingo
