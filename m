Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSLGMLh>; Sat, 7 Dec 2002 07:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSLGMLh>; Sat, 7 Dec 2002 07:11:37 -0500
Received: from [213.171.53.133] ([213.171.53.133]:11791 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S262464AbSLGMLg>;
	Sat, 7 Dec 2002 07:11:36 -0500
Date: Sat, 7 Dec 2002 12:56:18 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
Message-Id: <200212070956.gB79uIA9000640@ibe.miee.ru>
To: jsimmons@infradead.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.44.0212052039560.31967-100000@phoenix.infradead.org>
	(message from James Simmons on Thu, 5 Dec 2002 20:40:42 +0000 (GMT))
Subject: Re: [2.5.50] Keyboard dying
References: <Pine.LNX.4.44.0212052039560.31967-100000@phoenix.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >        After some X <-> back switches keyboard stops doing anything.
> >        2.5.50 + preempt enabled, X 4.2.1-debian-unstable.
> >
> > showkey started using gpm tells that the keys actually are pressed and
> > processed by the kernel.
> > Although even alt+sysrq+whatever do not make any effect.
> 
> Can you disable preempt and see if you have the same problem.

  Ok, i`ve booted it without preempt, but it`ll take time to make any
conclusions...
