Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVADPpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVADPpC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVADPpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:45:02 -0500
Received: from holomorphy.com ([207.189.100.168]:5768 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261686AbVADPo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:44:59 -0500
Date: Tue, 4 Jan 2005 07:34:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104153445.GH2708@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104150810.GD3097@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:57:38AM -0800, William Lee Irwin III wrote:
>> No amount of testing coverage will ever suffice. You're trying to
>> empirically establish the nonexistence of something, which is only
>> possible to repudiate, and never to verify.

On Tue, Jan 04, 2005 at 04:08:10PM +0100, Adrian Bunk wrote:
> I claim:
> The less and the less invasive patches go into the kernel, the less 
> likely are breakages.
> "enough" shouldn't say "mathematically exactly proven that no 
> regressions exist" but more something like the pretty small number of 
> regressions in recent 2.4 kernels.

The less that happens, the less likely it is for anything to happen.
You're effectively arguing that very little should happen.

This cannot be, because pure bugfixing activity alone would overwhelm
the limits on levels of activity you endorse. When it comes to design
flaws, a single fix for such would swamp the limits on activity you've
imposed for a significant portion of a year.

If you want more stability and fewer regressions, look for methods of
getting more peer review for patches, not fewer patches.


-- wli
