Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVJFJxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVJFJxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVJFJxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:53:21 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:41422 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1750766AbVJFJxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:53:20 -0400
Message-ID: <4344F39B.10806@cs.aau.dk>
Date: Thu, 06 Oct 2005 11:51:23 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org> <4343BB04.7090204@cs.aau.dk> <1128513584.2920.23.camel@laptopd505.fenrus.org> <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org> <4343C73E.9000507@cs.aau.dk> <20051006000741.GC18080@aitel.hist.no> <Pine.LNX.4.62.0510051741310.14560@qynat.qvtvafvgr.pbz> <4344EC64.2010400@aitel.hist.no>
In-Reply-To: <4344EC64.2010400@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Interesting argument, but it breaks for at least two reasons: 1. You
> can buy that box instead of just hiring it. That moves kernels 
> "outside the company", for money even.

I might have misunderstood but I think that if you buy the hardware you
cannot connect it to the DSLAM network anymore. So that only the boxes
they own are connected to the DSLAM.

> 2. It doesn't matter if they only move kernels withing their own 
> companys equipment. If they lend a customer equipment containing a
> linux kernel, then they're lending them a linux kernel.  Lending is
> distribution!

Are you sure this point has been clarified in court in the past ?
If not, I would bet on it (for the specific case of settop boxes).

> The argument might be fine, if they were moving linux kernels into 
> company equipment used by company personell only.  (I.e.
> linux-powered desktops/servers/gadgets for their employees.) And it
> might not. Maybe they actually have to distribute source to 
> employees too, if they request it.  The GPL only mentions recipients,
> no exceptions for "internal company use".  A company may perhaps
> demand that the employees never request the source, though. Or
> perhaps "internal use" is covered by the company being a "legal
> unit".

"internal use" is kind of a buzz word here and should probably be
clarified for this kind of cases.

For now, I really don't see the flaw in Free's argument.

I mentioned in another mail the case of a mobile phone network
infrastructure where the network nodes to which mobile phones are
connecting are running Linux. It seems to be an "internal use" (as it
never leak out of the company network) and yet providing a service to
customers.

The only difference in the Freeboxes case is that the node is at the
customer place (you can compare the customer's mobile phone to the
customer's computer plugged on the Freebox). But the fact that you don't
share your node with others and that you have it at home doesn't change
the fact that the company own it.

Has been any previous similar cases in the past which went in court ?

Maybe the best attack angle would be to say that if a GPL system is
interacting directly with a customer, then the source code should be
distributed. But I don't see if this requirement need changes in the GPL
(I'm ain't no expert).

Regards
-- 
Emmanuel Fleury

Always program as if the person who will be maintaining your program
is a violent psychopath that knows where you live.
  -- Unknown
