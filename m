Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbRDWWbc>; Mon, 23 Apr 2001 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRDWWbW>; Mon, 23 Apr 2001 18:31:22 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:3845 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S132462AbRDWWbH>; Mon, 23 Apr 2001 18:31:07 -0400
Message-Id: <200104232225.f3NMPHrn001690@pincoya.inf.utfsm.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 23 Apr 2001 16:52:53 +0100." <24644.988041173@redhat.com> 
Date: Mon, 23 Apr 2001 18:25:17 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:

[...]

> Then the kernel should say so, rather than giving a cryptic message like 
> that, and containing code which isn't actually guaranteed to compile, even 
> with a compiler which _does_ align the structure as we want it.

Your patch (tries to) transform a compile and link time check into a
runtime check. Not nice.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
