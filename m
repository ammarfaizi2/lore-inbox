Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbUCTOv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbUCTOv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:51:27 -0500
Received: from holomorphy.com ([207.189.100.168]:26760 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263430AbUCTOvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:51:22 -0500
Date: Sat, 20 Mar 2004 06:51:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040320145111.GD2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
	mjy@geizhals.at, linux-kernel@vger.kernel.org
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <405A584B.40601@cyberone.com.au> <20040319050948.GN2045@holomorphy.com> <20040320121423.GA9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320121423.GA9009@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 09:09:48PM -0800, William Lee Irwin III wrote:
>> Someone really needs to get numbers on this stuff.

On Sat, Mar 20, 2004 at 01:14:23PM +0100, Andrea Arcangeli wrote:
> Takashi already did it and we know it doesn't reduce the maximum latency.

I may have missed one of his posts where he gave the results from the
RT test suite. I found a list of functions with some kind of numbers,
though I didn't see a description of what those numbers were and was
looking for something more detailed (e.g. the output of the RT
instrumentation things he had with and without preempt). This is all
mostly curiosity and sort of hoping this gets carried out vaguely
scientifically anyway, so I'm not really arguing one way or the other.


-- wli
