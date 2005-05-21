Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVEUV3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVEUV3d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEUV17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 17:27:59 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29374 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261625AbVEUVZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 17:25:19 -0400
Message-Id: <200505210045.j4L0j8qO029162@laptop11.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Sat, 21 May 2005 02:19:25 +0200." <20050521001925.GQ5112@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 20 May 2005 20:45:08 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> said:
> Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> obsolete.
> 
> It seems to be time to remove it.

[...]

> -          The raw driver is deprecated and may be removed from 2.7
> -          kernels.  Applications should simply open the device (eg /dev/hda1)
> -          with the O_DIRECT flag.

To me, this sounds like a promise to keep it around for 2.6 at least...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
