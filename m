Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318982AbSIIVHj>; Mon, 9 Sep 2002 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318983AbSIIVHj>; Mon, 9 Sep 2002 17:07:39 -0400
Received: from ns.suse.de ([213.95.15.193]:63503 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318982AbSIIVH0>;
	Mon, 9 Sep 2002 17:07:26 -0400
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS?
References: <20020909193820.GA2007@lnuxlab.ath.cx.suse.lists.linux.kernel> <Pine.LNX.4.44.0209091457590.3793-100000@hawkeye.luckynet.adm.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Sep 2002 23:12:10 +0200
In-Reply-To: Thunder from the hill's message of "9 Sep 2002 23:03:37 +0200"
Message-ID: <p73wupuq34l.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@lightweight.ods.org> writes:

> Hi,
> 
> On Mon, 9 Sep 2002, khromy wrote:
> > What's up with XFS in linux-2.5? I've seen some patches sent to the list
> > but I havn't seen any replies from linus.. What needs to be done to
> > finally merge it?
> 
> It has been stated quite regularly that XFS
> a) doesn't always work like it should yet

That's quite bogus. While not being perfect XFS just works fine for lots
of people in production and performs very well for a lot of tasks.

> b) involves some changes which Linus doesn't like in particular, for 
>    pretty good reasons.

I think that's FUD too. That last patch had 6 lines or so of changes 
to generic code, everything else was already merged.

I guess it just ended up in Linus' spam filters, like some other things...

-Andi
