Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbULNUKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbULNUKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbULNUKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:10:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24741 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261634AbULNUIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:08:54 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <1103052853.3582.46.camel@localhost.localdomain>
References: <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>  <20041214132834.GA32390@elte.hu>
	 <1103052853.3582.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 15:08:27 -0500
Message-Id: <1103054908.14699.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 14:34 -0500, Steven Rostedt wrote:
> [RFC]
> 
> Ingo,
> 
> Any thought about adding a one shot timer for the system? 
> 

Isn't this what George Anzinger is working on?

http://sourceforge.net/projects/high-res-timers/

Lee

