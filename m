Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWBMUfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWBMUfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWBMUfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:35:04 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28947 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964861AbWBMUfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:35:01 -0500
Date: Mon, 13 Feb 2006 21:34:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mws <mws@twisted-brains.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.16, sk98lin out of date
Message-ID: <20060213203434.GI11380@w.ods.org>
References: <200602131058.03419.s0348365@sms.ed.ac.uk> <200602131206.26285.mws@twisted-brains.org> <1139857394.3202.38.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139857394.3202.38.camel@mindpipe>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 02:03:14PM -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 12:06 +0100, Mws wrote:
> > hi,
> > as i do have the same problem i may help you out.
> > 
> > at first, syskonnect did send their kernel diffs/patches but they
> > we're rejected caused
> > by coding style, indention and some people thinking that things can be
> > done better. 
> 
> Haha, they didn't like the LKML code review so they just stopped sending
> patches?  Classic.  Remind me not to buy their gear.

Lee, it's not always that simple. When you submit one driver, sometimes
reviewers tell you that for whatever reason your driver's structure is
wrong and it has to be changed a lot (and sometimes they're right of
course). But when you don't have enough ressource to do the job twice,
the best you can do is to maintain it out of tree, which is already a
pain. I'm not saying that it is what happened with their driver, I don't
know the history. However, I found your reaction somewhat hasty. I
personally would prefer to offer time and help before deciding that
I don't want anyone's products on this basis. It's not as if they
did not release their driver's source !

Cheers,
Willy

