Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRG2Aeq>; Sat, 28 Jul 2001 20:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267402AbRG2Aeg>; Sat, 28 Jul 2001 20:34:36 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:59653 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S265277AbRG2AeY>;
	Sat, 28 Jul 2001 20:34:24 -0400
Message-Id: <200107290033.f6T0Xk0D017023@sleipnir.valparaiso.cl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: make rpm 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Sun, 29 Jul 2001 01:20:19 +0100." <E15QeJf-0008O8-00@the-village.bc.nu> 
Date: Sat, 28 Jul 2001 20:33:42 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> I've been meaning to do this one for a while and I now have it working so
> that with my current -ac kernel working tree I can type
> 
> 	make rpm
> 
> and out puts kernel-2.4.7ac3-1.i386.rpm

Great idea!

Just the bunch of "echo this or that" is ugly as sin... why not a
kernel.spec template that gets its version &c substituted by sed(1) or
something?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
