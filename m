Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUG1WeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUG1WeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUG1Wco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:32:44 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:32005 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266603AbUG1WcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:32:15 -0400
Date: Wed, 28 Jul 2004 15:32:03 -0700
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040728223203.GA9009@nietzsche.lynx.com>
References: <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <1090968457.743.3.camel@mindpipe> <20040728050535.GA14742@elte.hu> <1091051452.791.52.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091051452.791.52.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 05:50:52PM -0400, Lee Revell wrote:
> With L2, 1:3, max_sectors_kb=256, and the above change, the performance
> is truly amazing.  Over 20 million interrupts, on a 600Mhz machine, the
> worst latency I was able to trigger was 46 usecs.  There does not seem
> to be any adverse affect on any aspect of the system.
> 
> This looks like the perfect setup for a DAW.

And as a musician into the notion of owning tons of pro-audio gear (I
don't at this time), I encourage you and the ALSA folks to go with it. :)

bill

