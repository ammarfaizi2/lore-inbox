Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752282AbWCPJVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbWCPJVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbWCPJVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:21:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49349 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752282AbWCPJVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:21:08 -0500
Date: Thu, 16 Mar 2006 10:18:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [patch] latency-tracing-v2.6.16.patch
Message-ID: <20060316091849.GB23098@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315220432.GA20926@elte.hu> <20060315223220.GB17817@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315223220.GB17817@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Rugolsky Jr. <brugolsky@telemetry-investments.com> wrote:

> > latency-tracing-v2.6.16.patch would be the one for current upstream 
> > kernels. The codebase is the same as in the -rt tree.
> 
> Ingo, I had to add this incremental patch against 2.6.16-rc6-git4 in 
> order to get the 2.6.15-rc7 latency tracer working on x86_64.  Looks 
> like the problem is still there in latency-tracing-v2.6.16.patch.

thanks, applied.

	Ingo
