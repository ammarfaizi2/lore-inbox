Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131433AbQKVBNr>; Tue, 21 Nov 2000 20:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbQKVBNh>; Tue, 21 Nov 2000 20:13:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11277 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130891AbQKVBNY>; Tue, 21 Nov 2000 20:13:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.0test11-ac1
Date: 21 Nov 2000 16:19:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vf3e1$192$1@hpa-p95.transmeta.com>
In-Reply-To: <8vf2oo$338$1@cesium.transmeta.com> <E13yNmg-0005QD-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13yNmg-0005QD-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> > 
> > Nononono... the 82489DX is an *external* APIC, which should be usable
> > on any Socket 5/7 CPU...
> 
> I know of no socket 7 board with an 82489DX, and no board on the planet which
> has 82489DX and works SMP with a non intel processor. I accept its a heuristic
> but so is the current behaviour, and the current heuristic isnt working for
> as many cases.
> 

Fair enough.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
