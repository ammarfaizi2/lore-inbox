Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKSLHS>; Mon, 19 Nov 2001 06:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRKSLHK>; Mon, 19 Nov 2001 06:07:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8716 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277798AbRKSLGy>; Mon, 19 Nov 2001 06:06:54 -0500
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Mon, 19 Nov 2001 11:14:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <15352.57742.799052.405674@notabene.cse.unsw.edu.au> from "Neil Brown" at Nov 19, 2001 09:40:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165mO5-0006En-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you missed part of my point.
> There are lots of different name spaces in the kernel.
> Filesystem names.  Driver names.  Module names.
> 
> But the namespace that is the current issue, the namespace of
> currently available devices, is not a namespace where I would expect
> trademarks to ever come up.  It is name space of interfaces and
> instances.

You mean like adaptec/aic7xxx/0 for the first aic7xxx controller when you
want to refer to an adaptec card ? And yes - you do need the ability to do
that kind of thing, not just talk generically about "disks".

So I still seek an answer. "Shrug, probably wont happen" isnt a good one

Alan
