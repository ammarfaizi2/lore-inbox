Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261636AbSJAOPH>; Tue, 1 Oct 2002 10:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSJAOPH>; Tue, 1 Oct 2002 10:15:07 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:31908 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261636AbSJAOPH>; Tue, 1 Oct 2002 10:15:07 -0400
From: Richard.Zidlicky@stud.informatik.uni-erlangen.de
Date: Tue, 1 Oct 2002 16:20:21 +0200 (MEST)
Message-Id: <200210011420.QAA13868@faui02b.informatik.uni-erlangen.de>
To: zippel@linux-m68k.org, phillips@arcor.de
Subject: Re: 2.4 mm trouble [possible lru race]
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The theoretical lru race possibly spotted in the wild...
> 
> >
> > Now I am wondering if that is just coincidence or why m68k hit that 
> > error so reliably.. is it supposed to have any effect at all on
> > UP?
> 
> Are you running UP+preempt?

no preempt or anything fancy, m68k vanila 2.4.19 (well almost).

Richard
