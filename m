Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbUCTPKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbUCTPKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:10:10 -0500
Received: from holomorphy.com ([207.189.100.168]:31112 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263439AbUCTPKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:10:05 -0500
Date: Sat, 20 Mar 2004 07:09:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040320150956.GE2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
	mjy@geizhals.at, linux-kernel@vger.kernel.org
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <405A584B.40601@cyberone.com.au> <20040319050948.GN2045@holomorphy.com> <20040320121423.GA9009@dualathlon.random> <20040320145111.GD2045@holomorphy.com> <20040320150311.GN9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320150311.GN9009@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 06:51:11AM -0800, William Lee Irwin III wrote:
>> I may have missed one of his posts where he gave the results from the
>> RT test suite. I found a list of functions with some kind of numbers,
>> though I didn't see a description of what those numbers were and was
>> looking for something more detailed (e.g. the output of the RT
>> instrumentation things he had with and without preempt). This is all
>> mostly curiosity and sort of hoping this gets carried out vaguely
>> scientifically anyway, so I'm not really arguing one way or the other.

On Sat, Mar 20, 2004 at 04:03:11PM +0100, Andrea Arcangeli wrote:
> agreed. what I've seen so far is a great number of graphs, they were
> scientific enough for my needs and covering real life different
> workloads, but I'm not sure what Takashi published exactly, you may want
> to discuss it with him.

I didn't see the graphs; they may be helpful for my purposes.


-- wli
