Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131714AbQKJXuZ>; Fri, 10 Nov 2000 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132174AbQKJXuP>; Fri, 10 Nov 2000 18:50:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5642 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131714AbQKJXt6>; Fri, 10 Nov 2000 18:49:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where is it written?
Date: 10 Nov 2000 15:49:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ui1j2$bm2$1@cesium.transmeta.com>
In-Reply-To: <3A0C2464.A7CDEFAB@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A0C2464.A7CDEFAB@mvista.com>
By author:    George Anzinger <george@mvista.com>
In newsgroup: linux.dev.kernel
>
> I thought this would be simple, but...
> 
> Could someone point me at the info on calling conventions to be used
> with x86 processors.  I need this to write asm code correctly and I
> suspect that it is a bit more formal than the various comments I
> have found in the sources.  Is it, perhaps an Intel doc?  Or a gcc
> thing?
>  

http://www.sco.com/developer/devspecs/abi386-4.pdf

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
