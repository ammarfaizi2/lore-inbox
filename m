Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267912AbRHFLAm>; Mon, 6 Aug 2001 07:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbRHFLAc>; Mon, 6 Aug 2001 07:00:32 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:31494 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267912AbRHFLAQ>;
	Mon, 6 Aug 2001 07:00:16 -0400
Message-Id: <200108051606.f75G6onM009519@sleipnir.valparaiso.cl>
To: rich+ml@lclogic.com, linux-kernel@vger.kernel.org
Subject: Re: module unresolved symbols 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Sun, 05 Aug 2001 11:48:45 +1000." <2261.996976125@ocs3.ocs-net> 
Date: Sun, 05 Aug 2001 12:06:50 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:
> On Sat, 4 Aug 2001 17:39:17 -0700 (PDT), 
> <rich+ml@lclogic.com> wrote:
> >Starting with a stock RH 7.0 install, I changed a single kernel config
> >item and recompiled with 'make defs clean bzImage modules
> >modules_install'.

> >Booted on the new kernel and depmod complains that dozens of modules
> >contain unresolved symbols. Back to the original kernel, now it also
> >complains of unresolved symbols (not the same set of modules, and modules
> >that were previously OK).

> Broken kernel makefiles when module symbols are turned on.
> http://www.tux.org/lkml/#s8-8

Or leftover modules from the stock install.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
