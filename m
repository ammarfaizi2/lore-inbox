Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287311AbSACOiD>; Thu, 3 Jan 2002 09:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287320AbSACOhx>; Thu, 3 Jan 2002 09:37:53 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:20234 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S287311AbSACOhq>; Thu, 3 Jan 2002 09:37:46 -0500
Message-Id: <200201031437.g03EbZwh022014@pincoya.inf.utfsm.cl>
To: Brian Gerst <bgerst@didntduck.org>
cc: esr@thyrsus.com, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Wed, 02 Jan 2002 22:34:42 CDT." <3C33D152.79FC8251@didntduck.org> 
Date: Thu, 03 Jan 2002 11:37:35 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> said:

[...]

> Then the best thing to do is to put a disclaimer on your
> autoconfiguration program: "WARNING: autoconfigure may not detect older
> hardware that was not designed for reliable detection.  If autoconfigure
> fails to detect all of your hardware, you may need to manually configure
> your kernel."

It is a lot easier just to leave a question in "Do you have old (ISA) cards
in your machine?"... solves 95% of the "problem" with minimal effort. The
question can then go for "Newbie configuration" in a few years.

> Sometimes perfection isn't worth the effort, especially when trying to
> support a class of hardware that is rapidly becoming obsolete.  Optimize
> for the most likely case, and deal with the rare corner cases with other
> means.

Bingo!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
