Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTAPIxy>; Thu, 16 Jan 2003 03:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTAPIxy>; Thu, 16 Jan 2003 03:53:54 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:28311 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S265570AbTAPIxy>; Thu, 16 Jan 2003 03:53:54 -0500
Message-Id: <200301152046.h0FKkS1Z001574@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Corey Minyard <cminyard@mvista.com>, linux-kernel@vger.kernel.org,
       Corey Minyard <minyard@mvista.com>
Subject: Re: IPMI 
In-Reply-To: Message from Rusty Russell <rusty@rustcorp.com.au> 
   of "Wed, 15 Jan 2003 14:49:55 +1100." <20030115044228.C33A82C054@lists.samba.org> 
Date: Wed, 15 Jan 2003 21:46:28 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:

[...]

> Now, the message.  How about this:
>        help
> 	  Intelligent Peripheral Management Interface (IPMI) is a
> 	  standard for managing sensors (temperature, voltage, etc.)
> 	  in a system.  Most IA64 and x86 servers shipped since 2002
> 	  have support for it.  See Documentation/IPMI.txt for more
> 	  details.  Say "N" unless configuring for a recent x86 or
> 	  IA64 machine.

Perhaps 'Say "Y" when configuring for a recent...' is clearer?
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
