Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbRGVCkj>; Sat, 21 Jul 2001 22:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267872AbRGVCkT>; Sat, 21 Jul 2001 22:40:19 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:8456 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267871AbRGVCkI>;
	Sat, 21 Jul 2001 22:40:08 -0400
Message-Id: <200107220023.f6M0Navr022281@sleipnir.valparaiso.cl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0" 
In-Reply-To: Your message of "Sat, 21 Jul 2001 12:38:15 -0400."
             <3B59AFF7.8061645B@mandrakesoft.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 21 Jul 2001 20:23:36 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jeff Garzik <jgarzik@mandrakesoft.com> said:
> "peter k." wrote:

> > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0" is
> > started automatically when booting (by the kernel obviously)? why? what
> > does it do?  i didnt find any useful information on it in linuxdoc /
> > linux-kernel archives

> it is used internally, ignore it.

I'd advise not to do so in general: It is a rather tempting name for
crackers to hide illegal activities.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
