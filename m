Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULOKSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULOKSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULOKSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:18:02 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:52920 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261155AbULOKSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:18:00 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Date: Wed, 15 Dec 2004 10:17:16 +0000
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
References: <20041122005411.GA19363@elte.hu> <1103076261.12657.709.camel@cmn37.stanford.edu> <20041215090900.GC13551@elte.hu>
In-Reply-To: <20041215090900.GC13551@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412151017.16233.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 Dec 2004 09:09, Ingo Molnar wrote:
>
> x64 wont work for now, it needs some work to make threaded timer IRQs
> work.
>

Don't leave it too long; I'm pretty sure I'm not the only x64 user wanting to 
test your -RT stuff.

I'm beginning to develop 32bit-envy ;)

Andrew Walrond
