Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTHWArH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 20:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTHWArG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 20:47:06 -0400
Received: from holomorphy.com ([66.224.33.161]:30617 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261192AbTHWArE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 20:47:04 -0400
Date: Fri, 22 Aug 2003 17:47:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: habanero@us.ibm.com, Bill Davidsen <davidsen@tmr.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org, mingo@elte.hu
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <20030823004743.GB3170@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>, habanero@us.ibm.com,
	Bill Davidsen <davidsen@tmr.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Erich Focht <efocht@hpce.nec.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
	torvalds@osdl.org, mingo@elte.hu
References: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com> <200308221046.31662.habanero@us.ibm.com> <3F469FA4.6020203@cyberone.com.au> <200308221912.38184.habanero@us.ibm.com> <3F46B561.7060706@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F46B561.7060706@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 10:29:21AM +1000, Nick Piggin wrote:
> Hmm... get someone to try the scheduler benchmarks on a 32 way box ;)

What scheduler benchmark?


-- wli
