Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQKIDWF>; Wed, 8 Nov 2000 22:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbQKIDVz>; Wed, 8 Nov 2000 22:21:55 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:53513 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129881AbQKIDVq>;
	Wed, 8 Nov 2000 22:21:46 -0500
Message-Id: <200011090219.eA92J2a10670@sleipnir.valparaiso.cl>
To: David Feuer <David_Feuer@brown.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia 
In-Reply-To: Message from David Feuer <David_Feuer@brown.edu> 
   of "Wed, 08 Nov 2000 17:24:18 CDT." <4.3.2.7.2.20001108172304.00adb270@postoffice.brown.edu> 
Date: Wed, 08 Nov 2000 23:19:02 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Feuer <David_Feuer@brown.edu> said:
> What is the current status of PC-card support?  I've seen ominous signs on 
> this list about the state of support....  I have a laptop with a PCMCIA 
> network card (a 3com thing). Will it work?

I've got a Toshiba Satellite Pro 4280xdvd + 3com cardbus 10/100 card. Works
fine with Red Hat 7, and also with 2.2.18pre20 + latest pcmcia-cs tools (X
doesn't work out of the box, I had to grab an X server from somewhere for
the S3 Savage IX the machine has. The builtin Lucent winmodem is hopeless,
BTW: The Lucent drivers just crash the kernel once the call is answered.)
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
