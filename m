Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTBGRtp>; Fri, 7 Feb 2003 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTBGRtp>; Fri, 7 Feb 2003 12:49:45 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:51425 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266175AbTBGRtl>; Fri, 7 Feb 2003 12:49:41 -0500
Message-Id: <200302071631.h17GV5d8011384@eeyore.valparaiso.cl>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, brand@eeyore.valparaiso.cl
Subject: Re: syscall documentation 
In-Reply-To: Your message of "Thu, 06 Feb 2003 21:05:52 +0100."
             <UTC200302062005.h16K5qn23586.aeb@smtp.cwi.nl> 
Date: Fri, 07 Feb 2003 17:31:05 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl said:
> The first one is alloc_hugepages.2. Below.

How about saying in CONFORMING TO that they only exist(ed) in that range of
kernels, for ia32 and ia64; and adding a DEPRECATED to the title?

And as this was during the current development series, what is the point of
manpages anyway?

Thanks for your efforts! This is certainly much needed work, which isn't
very "sexy".
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
