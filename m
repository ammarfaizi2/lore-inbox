Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274087AbRISPQD>; Wed, 19 Sep 2001 11:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274089AbRISPPx>; Wed, 19 Sep 2001 11:15:53 -0400
Received: from falka.mfa.kfki.hu ([148.6.72.6]:12734 "EHLO falka.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id <S274094AbRISPPr>;
	Wed, 19 Sep 2001 11:15:47 -0400
Date: Wed, 19 Sep 2001 17:14:32 +0200 (CEST)
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <3E975341CB7@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0109191711580.3210-100000@falka.mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 > If your answer is <=256MB, one module, no surprise then, as AFAIK nobody
 > with such config suffers from the problem. But checking also number of
 > memory modules looks more like black magic that anything else.
 > Hopefully VIA will answer...

Not exactly. I can report about two different machines - my home one, and
one here at workplace - which hit this bug. Linux even does not start on
them with 3R. Both of them have got 256 Mb, one module. This fix helps for
both of them.

Gergely

ps: ABIT KT7A, Duron 750MHz, 256Mb (one module)

