Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUGHN77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUGHN77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGHN77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:59:59 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3820 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263752AbUGHN76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:59:58 -0400
Message-Id: <200407081359.i68DxpLu011829@eeyore.valparaiso.cl>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: linux-kernel@vger.kernel.org, justin.piszcz@mitretek.org
Subject: Re: Does Optimization Effect BogoMips Value? 
In-Reply-To: Message from Justin Piszcz <jpiszcz@lucidpixels.com> 
   of "Wed, 07 Jul 2004 11:14:44 -0400." <Pine.LNX.4.60.0407071113400.24640@p500> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 08 Jul 2004 09:59:50 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz <jpiszcz@lucidpixels.com> said:
> Three identical Virtual Machines with three different compiler flags to
> compile the entire distribution, in this case, Gentoo 2004.1.
> 
> However, why are the Bogomips values different (up to +82 points
> different)?

Because the CPUs run at slightly different speeds? Because the cristals
that give PCs wall clock are inaccurate (82 in 4866 is 1.6%)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
