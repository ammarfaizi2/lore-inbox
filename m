Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVAFRDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVAFRDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVAFRDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:03:34 -0500
Received: from holomorphy.com ([207.189.100.168]:1211 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262908AbVAFRCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:02:43 -0500
Date: Thu, 6 Jan 2005 08:59:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050106165908.GA9636@holomorphy.com>
References: <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de> <20050104210117.GA7280@thunk.org> <20050106094519.GD20203@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106094519.GD20203@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 07:45:19AM -0200, Marcelo Tosatti wrote:
> You got to be kidding now?
> 99% of the features distributions have applied to their 2.4 based kernels 
> are "enterprise" features such as direct IO, AIO, etc.
> Really I can't recall any "attempt to make 2.4 stable" from the distros,
> its mostly "attempt to backport nice v2.6 feature".
> Do you have any example?
[tytso's comments elided]
> It took sometime to happen, but instability related to "high memory
> pressure" has been fixed in almost all cases long ago (the only
> remaining issue to my knowledged is loopback device with highmemory).
> I hardly see complaints of "crashes under load" problems since
> v2.4.19/20 or so.

I am unfortunately holding 2.4.x' earlier history against it. While you
were maintaining it, much of what we're discussing was resolved.
Unfortunately, the stabilization you're talking about was essentially
too late; distros had long-since wildly diverged, they had frozen on
older releases, and the damage to Linux' reputation was already done.
I'm also unaware of major commercial distros (e.g. Red Hat, SuSE) using
2.4.x more recent than 2.4.21 as a baseline, and it's also notable that
one of the largest segments of the commercial userbase I see is using a
distro kernel based on 2.4.9.

-- wli
