Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279717AbRKAUfr>; Thu, 1 Nov 2001 15:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279722AbRKAUfh>; Thu, 1 Nov 2001 15:35:37 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:39691 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S279717AbRKAUf1>; Thu, 1 Nov 2001 15:35:27 -0500
Message-Id: <200111012035.fA1KZMG11816@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6 (unkillable processes)
Date: Thu, 1 Nov 2001 14:35:05 -0600
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0111011212220.27747-100000@windmill.gghcwest.com>
In-Reply-To: <Pine.LNX.4.33.0111011212220.27747-100000@windmill.gghcwest.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 14:13, you wrote:
> On Thu, 1 Nov 2001, Nick LeRoy wrote:
> > Marked experiment, for now.  What about when it's no longer
> > "experimental"? Configuring a kernel to enable such a feature should
> > *not* break applications, especially something as prolific as xterm.
>
> Are you sure you know what you are talking about?  Devfs causes this
> problem because of a defect, not by design.  It is marked experimental
> because it's loaded with such defects.  Don't use it until the
> experimental tag is removed, if you are not prepared for some malfunction.

Yeah, I think that I know what I'm talking about.  The question was:  Should 
devfs be fixed, or should xterm be fixed.  I don't know how serious it is, or 
exactly what the nature of the problem is (haven't followed the thread that 
closely), but, from the "mile high" point of view, this defect, be it design 
or just a one-line bug, needs to be fixed before it can be tagged 
"non-experimental".  I don't understand why people would think otherwise, to 
be honest.

-Nick
