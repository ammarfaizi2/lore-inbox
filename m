Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUCIQkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCIQkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:40:06 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8205
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262049AbUCIQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:38:39 -0500
Date: Tue, 9 Mar 2004 17:39:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309163920.GN8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309155917.GH8193@dualathlon.random> <20040309160709.GA10577@elte.hu> <20040309160807.GA10778@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309160807.GA10778@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 05:08:07PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > this use more cpu than the previous one, but no other differences.
> > 
> > how fast is the system you tried this on? If it's faster than the 500
> > MHz box i tried it on then please try the attached test-mmap3.c.
> > (which is still not doing anything extreme.)
> 
> also, please run it on an UP kernel.

I will, thanks for the hint.
