Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbQKVCPs>; Tue, 21 Nov 2000 21:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132129AbQKVCPi>; Tue, 21 Nov 2000 21:15:38 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:23556 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131100AbQKVCPV>;
	Tue, 21 Nov 2000 21:15:21 -0500
Message-Id: <200011220144.eAM1iUf08680@sleipnir.valparaiso.cl>
To: David Hinds <dhinds@lahmed.stanford.edu>
cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules 
In-Reply-To: Message from David Hinds <dhinds@lahmed.stanford.edu> 
   of "Tue, 21 Nov 2000 16:04:44 -0800." <20001121160443.B18150@lahmed.stanford.edu> 
Date: Tue, 21 Nov 2000 22:44:30 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds <dhinds@lahmed.stanford.edu> said:

[...]

> Is there a technical reason for this?  Not that I know of; but then I
> also cannot think of a good reason for wanting, say, the generic code
> built in but the controller support as modules.  I do see reasonable
> arguments for all-builtin or all-modules.

If you have a laptop with an assortment of cards, you might want to have
the generic builtin and the cards themselves as modules.

Pretty weak, I know.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
