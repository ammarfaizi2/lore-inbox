Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbSLSBmJ>; Wed, 18 Dec 2002 20:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbSLSBmJ>; Wed, 18 Dec 2002 20:42:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:896 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267436AbSLSBmI>;
	Wed, 18 Dec 2002 20:42:08 -0500
Date: Wed, 18 Dec 2002 17:43:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <40720000.1040262220@flay>
In-Reply-To: <20021219003740.C20566@flint.arm.linux.org.uk>
References: <200212182237.gBIMbQmk000479@darkstar.example.net> <1040260157.26882.7.camel@irongate.swansea.linux.org.uk> <20021219003740.C20566@flint.arm.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This means I write (choose one):
> 
> 1. non-buggy code (highly unlikely)
> 2. code no one tests
> 3. code people do test but report via other means (eg, email, irc)
> 
> If it's (3), which it seems to be, it means that bugzilla is failing to
> do its job properly, which is most unfortunate.

Not everyone will end up using it ... if people want to log bugs from
lkml into bugzilla, I think that'd help gather a critical mass.

Are you getting a lot of bug-reports for serial code on lkml? I use it
heavily, and it seems to work just fine to me .... so I pick (1). Yay! ;-)

Some of the bugs in there lie fallow, but I've seen quite a few get fixed.
The fact that some people (Dave Jones springs to mind) trawl through there
being extremely helpful fixing things is very useful ;-) Lots of things got
fixed, though I can't *prove* it was solely due to it being in Bugzilla.

As the list of bugs increases, it'll become an increasingly powerful 
search engine for information as well .... I'll draw up a list of things
that don't seem to being worked on, and mail it out to kernel-janitors
and/or lkml and see if people are interested in fixing some of the fallow
stuff.

M.

