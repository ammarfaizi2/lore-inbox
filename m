Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRIGM2h>; Fri, 7 Sep 2001 08:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272621AbRIGM21>; Fri, 7 Sep 2001 08:28:27 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:21779 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S272620AbRIGM2O>; Fri, 7 Sep 2001 08:28:14 -0400
Message-Id: <200109071228.f87CSNMN017085@pincoya.inf.utfsm.cl>
To: ptb@it.uc3m.es
cc: "Bill Pringlemeir" <bpringle@sympatico.ca>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
In-Reply-To: Message from "Peter T. Breuer" <ptb@it.uc3m.es> 
   of "Fri, 07 Sep 2001 09:26:40 +0200." <200109070726.f877QeQ27567@oboe.it.uc3m.es> 
Date: Fri, 07 Sep 2001 08:28:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@it.uc3m.es> said:

[...]

> I don't know. I intended only to turn the sign bit on. I'm not sure how
> 1's complement arithmetic works, so I don't know if it works for 1's
> complement arithmetic.

C's unsigned arithmetic is 2-complement. Never even seen a 1-complement
machine.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
