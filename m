Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTAPSyE>; Thu, 16 Jan 2003 13:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTAPSyE>; Thu, 16 Jan 2003 13:54:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31122 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267217AbTAPSyB>;
	Thu, 16 Jan 2003 13:54:01 -0500
Date: Thu, 16 Jan 2003 20:07:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
In-Reply-To: <1042740441.826.55.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0301162006280.9051-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Jan 2003, Robert Love wrote:

> > Fine. This form is also nearer to the codingstyle rule: "functions
> > should do only one thing" (I'm reading those more carefully now ;-)
> 
> Good ;)
> 
> This is looking good.  Thanks hch for going over it with your fine tooth
> comb.
> 
> Erich and Martin, what more needs to be done prior to inclusion?  Do you
> still want an exec balancer in place?

well, it needs to settle down a bit more, we are technically in a
codefreeze :-)

	Ingo

