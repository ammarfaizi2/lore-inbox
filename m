Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbQLNNGJ>; Thu, 14 Dec 2000 08:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132451AbQLNNF7>; Thu, 14 Dec 2000 08:05:59 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:49933 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S132366AbQLNNFw>; Thu, 14 Dec 2000 08:05:52 -0500
Message-Id: <200012141232.eBECWRc30301@pincoya.inf.utfsm.cl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: kaos@ocs.com.au (Keith Owens), chris@chrullrich.de (Christian Ullrich),
        linux-kernel@vger.kernel.org
Subject: Re: insmod problem after modutils upgrading 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Wed, 13 Dec 2000 22:13:29 -0000." <E146K9T-0003MT-00@the-village.bc.nu> 
Date: Thu, 14 Dec 2000 09:32:27 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> In-Reply-To: <4381.976745113@ocs3.ocs-net> from "Keith Owens" at Dec 14, 2000 0
>      ***9:05:13 AM
> > previously because nobody used those options.  Since these are bugs in
> > the modules and only a few modules are affected (less than 5 reported),
> > the fix is to correct the modules that have coding errors.

> That wont be happening in 2.2 until 2.2.19 which probably means 6 months.
> If this is your decision please make it abundantly clear that the new
> modutils are a 2.4 only package.

Why can't you make a fast 2.2.19 with _just_ safe bug fixes (as the fixing
of these module problems certainly is)?
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
