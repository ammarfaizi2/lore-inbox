Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSKKORt>; Mon, 11 Nov 2002 09:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSKKORt>; Mon, 11 Nov 2002 09:17:49 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:19723 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S265325AbSKKORs>; Mon, 11 Nov 2002 09:17:48 -0500
Message-Id: <200211111424.gABEOCvc031091@pincoya.inf.utfsm.cl>
To: Pavel Machek <pavel@ucw.cz>
cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix confusing comment 
In-Reply-To: Message from Pavel Machek <pavel@ucw.cz> 
   of "Thu, 07 Nov 2002 18:09:36 BST." <20021107170936.GA432@elf.ucw.cz> 
Date: Mon, 11 Nov 2002 11:24:12 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> said:
> This little comment confused me a *lot*.
> 								Pavel
> 
> 
> --- clean/arch/i386/kernel/head.S	2002-10-14 18:18:30.000000000 +0200
> +++ linux-swsusp/arch/i386/kernel/head.S	2002-11-02 22:36:58.000000000 +
> 0100
> @@ -1,5 +1,5 @@
>  /*
> - *  linux/arch/i386/head.S -- the 32-bit startup code.
> + *  linux/arch/i386/kernel/head.S -- the 32-bit startup code.
>   *
>   *  Copyright (C) 1991, 1992  Linus Torvalds
>   *

I'd really prefer not to mention the path to the file, just its name (the
path is redundant anyway). Shorter, less space for confusion to creep in.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
