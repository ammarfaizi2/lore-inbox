Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVGGSqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVGGSqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVGGSqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:46:50 -0400
Received: from tantale.fifi.org ([64.81.251.130]:6789 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261578AbVGGSqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:46:45 -0400
To: Sheo Shanker Prasad <ssp@creativeresearch.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disturbing wide variation in execution time
References: <200507062344.53615.ssp@creativeresearch.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 07 Jul 2005 11:46:38 -0700
In-Reply-To: <200507062344.53615.ssp@creativeresearch.org>
Message-ID: <87oe9eo3n5.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sheo Shanker Prasad <ssp@creativeresearch.org> writes:

> I will appreciate your help in eliminating a disturbing wide
> variation (by a factors of 2 to 2.5) in the execution time of a test
> (execution benchmark) program under identical conditions even when
> the machine is freshly started (rebooted) and no other user program
> is running (not even e-mail or Internet browser).
> 
> I have a dual Opteron 250 (2.4 GHz) running SuSE 9.3 Pro & Linux
> version 2.6.11.4-21.7-smp (geeko@buildhost) (gcc version 3.3.5
> 20050117 (prerelease) (SUSE Linux)) #1 SMP Thu Jun 2 14:23:14 UTC
> 2005. The motherboard is Tyan Thunder K8W (S2885 ANRF) with AMI BIOS
> 
> The machine has 4GB of PC3200 DDR RAM, two dimms on each CPU.
> 
> The original machine bought from a vendor about 6 months ago. At
> that time it was running SuSE 9.1 Pro and the execution time for the
> same test program was consistently the same (around 2m 37s +/- a few
> %). Then the mother board failed and the machine went totally
> dead. The vendor then replaced the failed motherboard with a new
> Tyan Thunder K8W and installed the SuSE 9.3. I am not sure whether
> or not the AMI BIOS was also replaced.
> 
> When the repaired machine was started, I began to notice the
> disturbing wide variation and the frequect significant slow down of
> the machine as exhibited by the factor of 2 to 2.5 increased
> execution time of the test program as described above.  Sometimes it
> would be quite fast (executing at the original 2m 40s) and sometime
> a factor of 2.5 slow, and sometimes with speed in between.

8< snip >8

 1. Are you running an i386 kernel or an x86_64 kernel?

 2. Which BIOS version?

 3. Is node interleaving enabled in the BIOS?

Phil.
