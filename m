Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbTCGBWM>; Thu, 6 Mar 2003 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbTCGBWM>; Thu, 6 Mar 2003 20:22:12 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34258 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261325AbTCGBWL>;
	Thu, 6 Mar 2003 20:22:11 -0500
Message-Id: <200303070041.h270efZH007209@eeyore.valparaiso.cl>
To: Jonathan Lundell <linux@lundell-bros.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux vs Windows temperature anomaly 
In-Reply-To: Your message of "Wed, 05 Mar 2003 13:52:16 -0800."
             <p05210507ba8c20241329@[10.2.0.101]> 
Date: Thu, 06 Mar 2003 21:40:40 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell <linux@lundell-bros.com> said:
> We've been seeing a curious phenomenon on some PIII/ServerWorks 
> CNB30-LE systems.
> 
> The systems fail at relatively low temperatures. While the failures 
> are not specifically memory related (ECC errors are never a factor), 
> we have a memory test that's pretty good at triggering them. Data is 
> apparently getting corrupted on the front-side bus.
> 
> Here's the curious thing: when we run the same memory test on a 
> Windows 2000 system (same hardware; we just swap the disk), we can 
> run the ambient temperature up to 60C with no problem at all; the 
> test will run for days. (It occurred to us to try Win2K because the 
> hardware vendor was using it to test systems at temperature without 
> seeing problems.)
> 
> Swap in the Linux disk, and at that temperature it'll barely run at 
> all. The memory test fails quickly at 40C ambient.

Linux gives the hardware a _much_ harder workout than Windows.

My first PC was a P/100, overclocked to /120. WinNT worked fine, Linux
wouldn't even finish booting.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
