Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbVLGSm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbVLGSm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbVLGSm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:42:27 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24813 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751738AbVLGSm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:42:26 -0500
Message-Id: <200512071840.jB7IeNe8009407@laptop11.inf.utfsm.cl>
To: Arjan van de Ven <arjan@infradead.org>
cc: Bill Davidsen <davidsen@tmr.com>, Rob Landley <rob@landley.net>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Arjan van de Ven <arjan@infradead.org> 
   of "Wed, 07 Dec 2005 16:48:38 BST." <1133970518.2869.37.camel@laptopd505.fenrus.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Wed, 07 Dec 2005 15:40:23 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 07 Dec 2005 15:40:25 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> > The other group is the people who use and depend on some feature, be it 
> > cryptoloop, 8k stacks, ndiswrapper, ipchains, whatever... which is 
> > scheduled for extinction. 

Come on, most of those were scheduled for deletion a /long/ time ago.

> these are actually 2 groups
> 
> 1) people who depend on an in-kernel features
> 
> 2) people who depend on out of kernel / binary modules
> 
> treating them as one is not correct or fair to this thread.

Right.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
