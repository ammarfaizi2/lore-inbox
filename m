Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280510AbRKSSP0>; Mon, 19 Nov 2001 13:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280531AbRKSSPG>; Mon, 19 Nov 2001 13:15:06 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:4103 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S280510AbRKSSO7>; Mon, 19 Nov 2001 13:14:59 -0500
Message-Id: <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature? 
In-Reply-To: Message from vda <vda@port.imtp.ilyichevsk.odessa.ua> 
   of "Mon, 19 Nov 2001 19:21:57 -0000." <01111919215701.07749@nemo> 
Date: Mon, 19 Nov 2001 15:14:25 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua> said:
> On Monday 19 November 2001 16:44, Horst von Brand wrote:

[...]

> > X sets x for dirs, leaves files alone.

> Hmm... yes this is one of such workarounds already implemented.
> But it is not very good for my example:
> X sets x for dirs *and* for files with x set for any of u,g,o.
> 
> # chmod -R a+rX dir
> 
> will make any executables (even root only) world-executable.

That's what you are asking for...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
