Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbULCXJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbULCXJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 18:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbULCXJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 18:09:08 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:31669 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262457AbULCXJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 18:09:06 -0500
Date: Sat, 4 Dec 2004 00:08:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041203230855.GT32635@dualathlon.random>
References: <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <1102113437.13353.290.camel@tglx.tec.linutronix.de> <1102114310.13353.298.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102114310.13353.298.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 11:51:50PM +0100, Thomas Gleixner wrote:
> Ooops, sorry it did add something to the Log after 10 minutes

You mean my patch is preventing your machine to boot? Then you're doing
something else wrong because it's impossible my patch is preventing your
machine to boot. I also tested it before posting. You must have changed
something more than the PREEMPT bit after applying my patch.
