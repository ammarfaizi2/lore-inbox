Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQKABeO>; Tue, 31 Oct 2000 20:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131035AbQKABeE>; Tue, 31 Oct 2000 20:34:04 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:47629 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131016AbQKABdy>;
	Tue, 31 Oct 2000 20:33:54 -0500
Message-Id: <200011010133.eA11Xtr11638@sleipnir.valparaiso.cl>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks! 
In-Reply-To: Message from Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> 
   of "Tue, 31 Oct 2000 14:48:53 MDT." <200010312048.OAA244641@tomcat.admin.navo.hpc.mil> 
Date: Tue, 31 Oct 2000 22:33:54 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> said:

[...]

> Also pay attention to the security aspects of a true "zero copy" TCP stack.
> It means that SOMETIMES a user buffer will recieve data that is destined
> for a different process.

Why? AFAIKS, given proper handling of the issues involved, this can't
happen (sure can get tricky, but can be done in principle. Or am I
off-base?)
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
