Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbUJXSjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUJXSjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUJXSjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:39:40 -0400
Received: from mout2.freenet.de ([194.97.50.155]:44673 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261577AbUJXSji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:39:38 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BK kernel workflow
Date: Sun, 24 Oct 2004 20:39:25 +0200
User-Agent: KMail/1.7.1
References: <41752E53.8060103@pobox.com> <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org> <Pine.LNX.4.58.0410241045090.13209@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410241045090.13209@ppc970.osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242039.25407.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds <torvalds@osdl.org>:
> 
> On Sun, 24 Oct 2004, Linus Torvalds wrote:
> > 
> >    So BK helps this model, because the distributed nature of BK means that 
> >    you can have several pseudo-official trees _and_ totally unofficial
> >    ones, and merging is automatic and basically impossible to avoid, so 
> >    the "official" tree never gets to drown out the unofficial work. But 
> >    despite that, I want to make people _aware_ that maintainership does
> >    not imply total ownership, and that we don't have a "hierarchy" of 
> >    developers but a *network* of developers.
> 
> Btw, I've tried in the past to express why I think the BK model is so
> good, and why CVS ans Subversion totally suck, and I think the previous
> email perhaps explains it best.

What do kernel developers think about svk?
(Yes, it's not mature, yet.)
I mean the svk concept. Does it also suck for kernel development?

> It really is a very important conceptual thing, that "network" vs 
> "hierarchy" difference.  And I know we all love bashing Larry, but give 
> the guy a pat on the back for really making that difference visible.
> 
> [ Larry removed from the cc, because he's got ego enough as it is ;]

;)

>   Linus

Michael.
