Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272582AbRISXIt>; Wed, 19 Sep 2001 19:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274250AbRISXId>; Wed, 19 Sep 2001 19:08:33 -0400
Received: from Expansa.sns.it ([192.167.206.189]:9476 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S274256AbRISXH3>;
	Wed, 19 Sep 2001 19:07:29 -0400
Date: Thu, 20 Sep 2001 01:07:29 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <3E975341CB7@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0109200105300.25500-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Sep 2001, Petr Vandrovec wrote:

> On 19 Sep 01 at 17:31, Liakakis Kostas wrote:
> >
> > It seems to fix the stability problem. We don;t know why, but
> > experimetation shows that those _with_ the problem are relieved. This is
> > fine! We are happy with it.
> >
> > We write to a register marked as "don't write" by Via. This is potentialy
> > dangerous in ways we don't know yet.
>
> Just small question - you are saying that your KT133A works fine with
> 0x89... Two questions then - Do you have more than 256MB in your box?
> And second one: Do you have one, two, or three memory modules installed
> on the board?
>
> If your answer is <=256MB, one module, no surprise then, as AFAIK nobody
> with such config suffers from the problem. But checking also number of
> memory modules looks more like black magic that anything else.
> Hopefully VIA will answer...
Just to add a curiosity. Abit KT7A MBs do not accept all 256 MB modules.
with some of them they do see just 128 MB, and anyway systems are stable,
but of course systems managers get unhappy.
This should be because of modules density...

OK, this was OT but maybe some of you had this experience.

Luigi


