Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTAPLBW>; Thu, 16 Jan 2003 06:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbTAPLBW>; Thu, 16 Jan 2003 06:01:22 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:10154 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266318AbTAPLBV>; Thu, 16 Jan 2003 06:01:21 -0500
Message-Id: <200301161104.h0GB4IOY011937@eeyore.valparaiso.cl>
To: DervishD <raul@pleyades.net>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited... 
In-Reply-To: Message from DervishD <raul@pleyades.net> 
   of "Wed, 15 Jan 2003 19:44:55 +0100." <20030115184455.GB47@DervishD> 
Date: Thu, 16 Jan 2003 12:04:18 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <raul@pleyades.net>

[No attributions here, sorry]

> > > welcome. Although I would like a portable solution, any solution that
> > > works under *any* Linux kernel is welcome...
> > What about mounting /proc from inside your program? Not a big deal, easy
> > sollution ... 

>     I don't like it, because it should happen at the very beginning
> of init. Remember, is not any program, is an init. Should be a more
> clean way, I suppose :??

If it is init, you do have enough control over the environment to just
hardcode the executable's name?

In any case, I don't see what you want to acomplish here. Care to enligthen
us a bit?
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
