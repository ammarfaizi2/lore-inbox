Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUJXRtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUJXRtY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUJXRtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:49:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:54695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261570AbUJXRtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:49:05 -0400
Date: Sun, 24 Oct 2004 10:48:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410241045090.13209@ppc970.osdl.org>
References: <41752E53.8060103@pobox.com>  <20041019153126.GG18939@work.bitmover.com>
  <41753B99.5090003@pobox.com>  <4d8e3fd304101914332979f86a@mail.gmail.com>
  <20041019213803.GA6994@havoc.gtf.org>  <4d8e3fd3041019145469f03527@mail.gmail.com>
  <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>  <20041023161253.GA17537@work.bitmover.com>
 <4d8e3fd304102403241e5a69a5@mail.gmail.com> <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Oct 2004, Linus Torvalds wrote:
> 
>    So BK helps this model, because the distributed nature of BK means that 
>    you can have several pseudo-official trees _and_ totally unofficial
>    ones, and merging is automatic and basically impossible to avoid, so 
>    the "official" tree never gets to drown out the unofficial work. But 
>    despite that, I want to make people _aware_ that maintainership does
>    not imply total ownership, and that we don't have a "hierarchy" of 
>    developers but a *network* of developers.

Btw, I've tried in the past to express why I think the BK model is so
good, and why CVS ans Subversion totally suck, and I think the previous
email perhaps explains it best.

It really is a very important conceptual thing, that "network" vs 
"hierarchy" difference.  And I know we all love bashing Larry, but give 
the guy a pat on the back for really making that difference visible.

[ Larry removed from the cc, because he's got ego enough as it is ;]

		Linus
