Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVKWS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVKWS2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVKWS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:28:36 -0500
Received: from khepri.openbios.org ([80.190.231.112]:61367 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S932148AbVKWS2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:28:35 -0500
Date: Wed, 23 Nov 2005 19:28:31 +0100
From: Stefan Reinauer <stepan@openbios.org>
To: Andi Kleen <ak@suse.de>
Cc: Ronald G Minnich <rminnich@lanl.gov>, discuss@x86-64.org,
       linuxbios@openbios.org, linux-kernel@vger.kernel.org,
       yhlu <yhlu.kernel@gmail.com>
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123182831.GA31870@openbios.org>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <20051123173504.GK20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123173504.GK20775@brahms.suse.de>
X-Operating-System: Linux 2.6.14-20051104171614-smp on an x86_64
User-Agent: Mutt/1.5.9i
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [051123 18:35]:
> > At the same time, we seem to be treading in territory where the fuctory 
> > BIOSes have not yet been. We're in the weird position, at times, of 
> > finding things out before the proprietary BIOSes get there.
> 
> You're saying that Arima machine only runs with LinuxBIOS so far?

Island/Aruma. The only production level firmware is LinuxBIOS, indeed.

Others have failed.

Stefan



