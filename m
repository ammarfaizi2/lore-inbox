Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTBXIlU>; Mon, 24 Feb 2003 03:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbTBXIlU>; Mon, 24 Feb 2003 03:41:20 -0500
Received: from holomorphy.com ([66.224.33.161]:58031 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265667AbTBXIlT>;
	Mon, 24 Feb 2003 03:41:19 -0500
Date: Mon, 24 Feb 2003 00:50:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Bill Huey <billh@gnuppy.monkey.org>, lm@work.bitmover.com,
       mbligh@aracnet.com, davidsen@tmr.com, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224085031.GP10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Bill Huey <billh@gnuppy.monkey.org>,
	lm@work.bitmover.com, mbligh@aracnet.com, davidsen@tmr.com,
	greearb@candelatech.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224004005.5e46758d.akpm@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (Hui) <billh@gnuppy.monkey.org> wrote:
>> especially given some of the IO performance improvement that
>> happened as a courtesy of preempt.

On Mon, Feb 24, 2003 at 12:40:05AM -0800, Andrew Morton wrote:
> There is no evidence for any such thing.  Nor has any plausible
> theory been put forward as to why such an improvement should occur.

There's a vague notion in my head that it should decrease scheduling
latencies in general, possibly including responses to io completion.

No idea how that lines up with reality. You've actually tracked
scheduling latencies at least at some point in the past. What kind
of results have you seen from the stuff (if any)?


-- wli
