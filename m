Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSFPCJy>; Sat, 15 Jun 2002 22:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSFPCJx>; Sat, 15 Jun 2002 22:09:53 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:45581 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S315792AbSFPCJx>;
	Sat, 15 Jun 2002 22:09:53 -0400
Message-Id: <200206160110.g5G1AI9S005403@sleipnir.valparaiso.cl>
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][TRIVIAL] Print a KERN_INFO after a module gets loaded 
In-Reply-To: Your message of "Sat, 15 Jun 2002 01:27:31 EDT."
             <Pine.LNX.4.44.0206150035290.5254-100000@alumno.inacap.cl> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sat, 15 Jun 2002 21:10:18 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robinson Maureira Castillo <rmaureira@alumno.inacap.cl> said:
> After some thinking (nothing serious) I came up with the idea of print a 
> KERN_INFO after a module got loaded, why? Think about this, some guy 
> inserts a LKM rootkit, obviously that module (think adore or knark) 
> doesn't say anything when it gets loaded. In this cases is useful to have 
> this feature, another example can be simply now the order of a group of 
> pre-requisite modules when you load something using modprobe(8).

If the cracker gets to the stage where they can insert modules at will, you
can't believe anything the machine does or says anymore.
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
