Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSKBXiD>; Sat, 2 Nov 2002 18:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSKBXiC>; Sat, 2 Nov 2002 18:38:02 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:40718 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261509AbSKBXiC>; Sat, 2 Nov 2002 18:38:02 -0500
Message-Id: <200211022344.gA2NiEgo002637@pincoya.inf.utfsm.cl>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over. 
In-reply-to: Your message of "Thu, 31 Oct 2002 09:54:50 -0800."
             <Pine.LNX.4.44.0210310941310.20412-100000@nakedeye.aparity.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 02 Nov 2002 20:44:13 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matt D. Robinson" <yakker@aparity.com> dijo:

[...]

> This isn't bloat.  If you want, it can be built as a module, and
> not as part of your kernel.  How can that be bloat?  People who
> build kernels can optionally build it in, but we're not asking
> that it be turned on by default, rather, built as a module so
> people can load it if they want to.  We made it into a module
> because 18 months ago you complained about it being bloat.  We
> addressed your concerns.

Bloat is not just RAM/CPU/... usage when in use, it is much more about
developers who have to understand, work with, and consider how to use or
interface with the new code. Even more so when it is not builtin, as this
creates _two_ scenarios to consider.

This is the sense of "bloat" that Linus is most worried about (and very
rightly so, IMVHO). At lesat that is my observation over the years.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
