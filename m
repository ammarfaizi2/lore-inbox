Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVGUNxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVGUNxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 09:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVGUNxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 09:53:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50588 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261786AbVGUNxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 09:53:43 -0400
Message-Id: <200507211353.j6LDrcNH003711@laptop11.inf.utfsm.cl>
To: Jiri Slaby <lnx4us@gmail.com>
cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete files in 2.6 tree 
In-Reply-To: Message from Jiri Slaby <lnx4us@gmail.com> 
   of "Thu, 21 Jul 2005 11:47:32 +0200." <42DF6F34.4080804@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 21 Jul 2005 09:53:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 21 Jul 2005 09:53:39 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <lnx4us@gmail.com> wrote:
> Jiri Slaby napsal(a):
> > Are these files obsolete and could be deleted from tree.
> > Does anybody use them? Could anybody compile them?
> 
> New list should be:

[...]

> sound/oss/skeleton.c

I think skeleton.* files are there as examples, not for real use. Sure,
they should be checked that they are up to date and fixed as required.

OSS is obsolete, so this could probably be axed when/if it finally is deleted.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
