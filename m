Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTAaJX3>; Fri, 31 Jan 2003 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTAaJX3>; Fri, 31 Jan 2003 04:23:29 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:20612 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267738AbTAaJX3>; Fri, 31 Jan 2003 04:23:29 -0500
Message-Id: <200301310932.h0V9Wmwn002827@eeyore.valparaiso.cl>
To: Jared Young <headgeek@li.nu-x.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Small bug in linux-2.4.20/include/linux/kernel.h 
In-Reply-To: Your message of "Thu, 30 Jan 2003 23:58:53 EST."
             <20030130235853.7a2b4dcb.headgeek@li.nu-x.net> 
Date: Fri, 31 Jan 2003 10:32:48 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jared Young <headgeek@li.nu-x.net> said:

> Perhaps this is a small bug: During a compile for 2.4.20 there comes a
> section in /include/linux/kernel.h that calls for #include <stdarg.h>
> however stdarg.h is not included or found in any of the source
> directories.

It is part of gcc.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
