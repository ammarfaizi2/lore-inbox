Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSLROC5>; Wed, 18 Dec 2002 09:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbSLROC5>; Wed, 18 Dec 2002 09:02:57 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:45060 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S264672AbSLROC5>; Wed, 18 Dec 2002 09:02:57 -0500
Message-Id: <200212181410.gBIEAod6027746@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance 
In-Reply-To: Message from Sean Neakums <sneakums@zork.net> 
   of "Wed, 18 Dec 2002 13:47:24 -0000." <6u4r9bsakz.fsf@zork.zork.net> 
Date: Wed, 18 Dec 2002 11:10:50 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> said:
> commence  Horst von Brand quotation:
> 
> > [Extremely interesting new syscall mechanism tread elided]
> >
> > What happened to "feature freeze"?
> 
> How are system calls a new feature?  Or is optimizing an existing
> feature not allowed by your definition of "feature freeze"?

This "optimizing" is very much userspace-visible, and a radical change in
an interface this fundamental counts as a new feature in my book.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
