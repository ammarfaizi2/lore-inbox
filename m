Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVCPR2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVCPR2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCPR2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:28:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3638
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262702AbVCPR2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:28:52 -0500
Date: Wed, 16 Mar 2005 18:28:50 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050316172850.GF11192@opteron.random>
References: <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315150526.GA14744@elte.hu> <20050315164420.GT7699@opteron.random> <20050316082851.GB10260@elte.hu> <20050316104618.GB11192@opteron.random> <20050316134150.GA24970@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316134150.GA24970@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:41:50PM +0100, Ingo Molnar wrote:
> password issue. (But i guess after many years i should be wiser not to
> get into such arguments with you.) [..]

Your last emails about math proofs, social engineering and selfish NIH
syndrome were ridiculous, and now you get personal.

After all those emails I never heard a good argument from you that made
me even slightly consider changing my plans and to use ptrace instead of
seccomp, and at the end you are degenerating, so I'll have to take it as
a contrarian indicator.

Drop seccomp from the RH kernels if that makes you feel better. You can
always patch the Cpushare client to use ptrace instead of seccomp if you
want. Put your code where your mouth is, the config option is there,
keep it to N.
