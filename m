Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTLBP62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 10:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTLBP62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 10:58:28 -0500
Received: from intra.cyclades.com ([64.186.161.6]:1703 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262228AbTLBP6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 10:58:25 -0500
Date: Tue, 2 Dec 2003 13:50:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Russell Cattelan <cattelan@xfs.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nathan Scott <nathans@sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
In-Reply-To: <1070379282.82397.29.camel@lupo.thebarn.com>
Message-ID: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Russell Cattelan wrote:

> On Tue, 2003-12-02 at 05:18, Marcelo Tosatti wrote:
> [snip] 
> > Also I'm not completly sure if the generic changes are fine and I dont
> > like the XFS code in general.
> Ahh so the real truth comes out.
> 
> 
> Is there a reason for your sudden dislike of the XFS code?

I always disliked the XFS code. 

> or is this just an arbitrary general dislike for unknown or unstated
> reasons?

I dont like the style of the code. Thats a personal issue, though, and 
shouldnt matter.

The bigger point is that XFS touches generic code and I'm not sure if that 
can break something.

Why it matters so much for you to have XFS in 2.4 ? 


