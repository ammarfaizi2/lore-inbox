Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270811AbUJUSi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbUJUSi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbUJUSfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:35:45 -0400
Received: from brown.brainfood.com ([146.82.138.61]:4992 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S270721AbUJUSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:34:14 -0400
Date: Thu, 21 Oct 2004 13:34:05 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
In-Reply-To: <20041021132717.GA29153@elte.hu>
Message-ID: <Pine.LNX.4.58.0410211333340.1252@gradall.private.brainfood.com>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
 <20041021132717.GA29153@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, Ingo Molnar wrote:

>  + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U9

For those using kernel-package, I just submitted a patch to allow for
uppercase versions.

http://bugs.debian.org/277680
