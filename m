Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131034AbQKTC7p>; Sun, 19 Nov 2000 21:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131106AbQKTC7g>; Sun, 19 Nov 2000 21:59:36 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:3345 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131061AbQKTC7V>;
	Sun, 19 Nov 2000 21:59:21 -0500
Message-Id: <200011200105.eAK15S910427@sleipnir.valparaiso.cl>
To: Markus Schoder <markus_schoder@yahoo.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: Freeze on FPU exception with Athlon 
In-Reply-To: Message from Markus Schoder <markus_schoder@yahoo.de> 
   of "Sat, 18 Nov 2000 19:22:30 BST." <20001118182230.14470.qmail@web3407.mail.yahoo.com> 
Date: Sun, 19 Nov 2000 22:05:28 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?q?Markus=20Schoder?= <markus_schoder@yahoo.de> said:

[...]

> I will also try to compile a non AMD specific kernel
> and see if that makes a difference.  If just this 40GB
> drive would fsck faster :)

mount -o remount,ro [...]
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
