Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbSLELPk>; Thu, 5 Dec 2002 06:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbSLELPj>; Thu, 5 Dec 2002 06:15:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:11909 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267286AbSLELPi>;
	Thu, 5 Dec 2002 06:15:38 -0500
Message-Id: <200212050042.gB50ga4C001486@eeyore.valparaiso.cl>
To: Alexander.Riesen@synopsys.com
cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken? 
In-Reply-To: Message from Alex Riesen <Alexander.Riesen@synopsys.com> 
   of "Wed, 04 Dec 2002 15:26:28 BST." <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> 
Date: Wed, 04 Dec 2002 21:42:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <Alexander.Riesen@synopsys.com> said:

[...]

> looks correct. The interpreter (/bin/sh) has got everything after
> its name. IOW: "-- # -*- perl -*- -T"
> It's just solaris' shell (/bin/sh) just ignores options starting with
> "--". And freebsd's as well.

And Linux's too. Try it.
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
