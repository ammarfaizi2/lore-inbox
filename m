Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUGGQRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUGGQRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUGGQRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:17:18 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:18074 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265214AbUGGQRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:17:17 -0400
Subject: Re: 2.6.7-ck5
From: Redeeman <lkml@metanurb.dk>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       John Richard Moser <nigelenki@comcast.net>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
In-Reply-To: <40EC1C85.9030008@gmx.de>
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
	 <40EC1B0A.8090802@kolivas.org>  <40EC1C85.9030008@gmx.de>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 18:17:08 +0200
Message-Id: <1089217028.31825.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 17:53 +0200, Prakash K. Cheemplavam wrote:
> Con Kolivas wrote:
> > John Richard Moser wrote:
> >> When do you think the staircase, batch, and isometric scheduling will
> >> reach mainline-quality?  Do you think you'll be ready to ask Andrew to
> >> merge it soon, or will it be a while before it's quite ready for that?
> > 
> > 
> > Well I think they're all ready for prime time now, I just dont think 
> > prime time is ready for it. This is too large a change for mainline 2.6 
> > which keeps -ck in business ;)
> 
> I don't know whether this was already discussed, but what about adding 
> framework so that (like io-schedulers) the cpu scheduler could be chosen 
> on boot time? This would make it easy to test different cpu schedulers.
might be a good idea, but i dont think doing such a change in 2.6 is
good, but for 2.7, a good idea
> 
> Cheers,
> 
> Prakash
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

