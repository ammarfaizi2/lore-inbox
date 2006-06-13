Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWFMU2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWFMU2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWFMU2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:28:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58761 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932127AbWFMU2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:28:12 -0400
Message-Id: <200606132027.k5DKR6ie015928@laptop11.inf.utfsm.cl>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       janpascal@vanbest.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] NI5010 netcard cleanup (was: Re: NI5010 network driver -- MAINTAINERS entry) 
In-Reply-To: Message from Andreas Mohr <andi@rhlx01.fht-esslingen.de> 
   of "Tue, 13 Jun 2006 21:06:58 +0200." <20060613190658.GA396@rhlx01.fht-esslingen.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 13 Jun 2006 16:27:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 13 Jun 2006 16:27:07 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

[...]

> @@ -47,7 +43,7 @@
>   *			-DMODULE -c ni5010.c 
>   *
>   *	Insert with e.g.:
> - *		insmod ni5010.o io=0x300 irq=5 	
> + *		insmod ni5010.o io=0x300 irq=5
>   */

Should now be .ko ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
