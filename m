Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129342AbQJ3Uwi>; Mon, 30 Oct 2000 15:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQJ3Uw2>; Mon, 30 Oct 2000 15:52:28 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:1285 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129112AbQJ3UwS>; Mon, 30 Oct 2000 15:52:18 -0500
Message-Id: <200010302050.e9UKo7312002@pincoya.inf.utfsm.cl>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Peter Samuelson <peter@cadcamlab.org>,
        Linux Kernel Developer <linux_developer@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler? - Re: [patch] kernel/module.c (plus gratuitous rant) 
In-Reply-To: Message from Martin Dalecki <dalecki@evision-ventures.com> 
   of "Mon, 30 Oct 2000 14:49:03 BST." <39FD7C4F.74D8DCCC@evision-ventures.com> 
Date: Mon, 30 Oct 2000 17:50:07 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com> said:
> Peter Samuelson wrote:

[...]

> > * Red Hat "2.96" or CVS 2.97 will probably break any known kernel.

> Works fine for me and 2.4.0-test10-pre5... however there are tons of
> preprocessor warnings in some drivers.

CVS (from 20001028 or so) gave a 2.4.0.10.6/i686 that crashed on boot, no
time to dig deeper yet.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
