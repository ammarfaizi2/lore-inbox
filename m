Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRGVQm6>; Sun, 22 Jul 2001 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268000AbRGVQms>; Sun, 22 Jul 2001 12:42:48 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:24584 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267997AbRGVQmb>;
	Sun, 22 Jul 2001 12:42:31 -0400
Message-Id: <200107221642.f6MGgAfl019732@sleipnir.valparaiso.cl>
To: "Mike Black" <mblack@csihq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: 2.4.7: wtf is "ksoftirqd_CPU0" 
In-Reply-To: Message from "Mike Black" <mblack@csihq.com> 
   of "Sun, 22 Jul 2001 06:24:06 -0400." <009601c11298$70a3da80$b6562341@cfl.rr.com> 
Date: Sun, 22 Jul 2001 12:42:04 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Mike Black" <mblack@csihq.com> said:
> Actually -- is it possible (or desirable) to make ALL kernel daemons begin
> with say "_" or some other special character to distinguish them from
> userland threads?  The "k......d" paradigm is OK but not very distinctive.
> That way you have a simple line in the kernel docs that says "Any process
> with a leading _ is a kernel process and should NEVER be killed or otherwise
> messed with except as noted elsewhere in the docs".

It is rather easy to fake any process name.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
