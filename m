Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbUKLKzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUKLKzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUKLKzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:55:19 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:14084 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262502AbUKLKxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:53:35 -0500
Date: Fri, 12 Nov 2004 02:52:37 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041112105237.GA1689@nietzsche.lynx.com>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041112040845.GA26545@nietzsche.lynx.com> <20041112050309.GA1207@nietzsche.lynx.com> <20041112083938.GA20732@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112083938.GA20732@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 09:39:38AM +0100, Ingo Molnar wrote:
> * Bill Huey <bhuey@lnxw.com> wrote:
> > > Patch to get rudimentary kgdb support working.
> 
> thanks, the patch looks good. Is this one really needed:

No, it's not. It's for my timing stuff that's going to be release
as soon as I figure out how to deal with the irq balancing code.
(I'm still learning this as I go along)

I'm a newbie to releasing patches, so scold me when you feel it's
appropriate. :)

bill

