Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKHMG3>; Wed, 8 Nov 2000 07:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKHMGT>; Wed, 8 Nov 2000 07:06:19 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:60420 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129057AbQKHMGL>; Wed, 8 Nov 2000 07:06:11 -0500
Message-Id: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> 
   of "Tue, 07 Nov 2000 21:41:47 PDT." <20001107214147.B8542@vger.timpanogas.org> 
Date: Wed, 08 Nov 2000 09:05:56 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> said:

[...]

> Your way out in the weeds.  What started this thread was a customer who
> ended up loading the wrong arch on a system and hanging.  I have to
> post a kernel RPM for our release, and it's onerous to make customers
> recompile kernels all the time and be guinea pigs for arch ports.  

I'd prefer to be a guinea pig for one of 3 or 4 generic kernels distributed
in binary than of one of the hundreds of possibilities of patching a kernel
together at boot, plus the (presumamby rather complex and fragile)
machinery to do so *before* the kernel is booted, thank you very much.

Plus I'm getting pissed off by how long a boot takes as it stands today...

> They just want it to boot, and run with the same level of ease of use
> and stability they get with NT and NetWare and other stuff they are used
> to.   This is an easy choice from where I'm sitting.

Easy: i386. Or i486 (I very much doubt your customers run on less, and this
should be geneic enough).
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
