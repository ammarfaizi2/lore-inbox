Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbTA2Jsg>; Wed, 29 Jan 2003 04:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTA2Jsg>; Wed, 29 Jan 2003 04:48:36 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:58303 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S265661AbTA2Jsf>; Wed, 29 Jan 2003 04:48:35 -0500
Message-Id: <200301290957.h0T9vqUL011886@eeyore.valparaiso.cl>
To: Jos Hulzink <josh@stack.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Module security [Was: Re: Bootscreen]
In-Reply-To: Your message of "Tue, 28 Jan 2003 15:45:45 +0100."
             <20030128153533.X28781-100000@snail.stack.nl> 
Date: Wed, 29 Jan 2003 10:57:52 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink <josh@stack.nl> said:

[...]

> Oh, and using modules is a (minor) security issue. I have all my drivers
> compiled in the kernel. I like it and it is secure.

There are ways of installing rogue "modules" even without module support.
Google and ye shall find... [One of the online cracker mags had an
extensive article on module/kernel based rootkits some 6-10 months
ago]. And if "someone" gets root, they can leave behind a doctored kernel
any time they want. You'll never notice...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
