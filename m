Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUHVRRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUHVRRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUHVRRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:17:47 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48353 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268032AbUHVRRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:17:44 -0400
Message-Id: <200408221511.i7MFBW2I002954@localhost.localdomain>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: der.eremit@email.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices 
In-Reply-To: Message from Joerg Schilling <schilling@fokus.fraunhofer.de> 
   of "Sun, 22 Aug 2004 14:14:08 +0200." <41288E10.nail9MX3BDIPM@burner> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sun, 22 Aug 2004 11:11:32 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> said:

[...]

> And the wrong decision could have even be avoided if people did contact me
> before they did act....

Exactly! They should also contact me and ask politely each time they
consider a change if I'd allow it. Really. The nerve these guys have.
Unbelievable.

In the end, I'd only say that I've been on LKML for a long, long time
(since it started, more or less). And each single time the head hackers
agreed on something, and there was a single dissenter, the dissenter was in
the wrong. Sure, this time could be different, but I have seen absolutely
no (yes, _no_) evidence here to the contrary.

The kernel changed, badly conceived interfases were (somewhat, perhaps
broken in another way) fixed. Some applications that depended on the
brokenness don't work now. Tough luck, fix the applications and
(optionally) ask _politely_, with _detailed discussion_, perhaps propose a
better fix for the kernel. Just whining that the application broke during
its "code freeze" won't get you anywhere (you just can't expect to hold the
kernel hostage to your random, mostly unrelated, program's development
schedule; that model just won't get anywhere real fast). 

Treating everybody as ignorant morons isn't exactly the best way to be
heard. And in this case there is ample evidence on hand that they are very
smart people who usually are right in regards to the techical matters they
have in their hands.

I.e., you are making a fool of yourself here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
