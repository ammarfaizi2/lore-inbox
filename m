Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280876AbRKLRlI>; Mon, 12 Nov 2001 12:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280872AbRKLRk6>; Mon, 12 Nov 2001 12:40:58 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:48693 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S280876AbRKLRku>; Mon, 12 Nov 2001 12:40:50 -0500
From: joeja@mindspring.com
Date: Mon, 12 Nov 2001 12:40:43 -0500
To: jjs@pobox.com
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Re: loop back broken in 2.2.14
Message-ID: <Springmail.105.1005586843.0.91657700@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I can delete out those two lines to get loop working.

Is 2.4.x really a stable tree?  Or should I wait for 2.4.25 before I consider it really stable?

> > François Cami wrote:
> >
> > > yes, see 2.4.15pre1
> > > warning, the iptables code in 2.4.15pre1 and pre2 seems broken.
> >
> > and further it is likely that pre3 fixes iptables code :)
> > (it looks like the patch got reverted)
>
> Actually it doesn't seem to be reverted,
> just reworked -

hmm, spoke too soon -

looks like they were reverted after all...

cu

jjs


