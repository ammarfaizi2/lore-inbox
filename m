Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132400AbQK3Axj>; Wed, 29 Nov 2000 19:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132408AbQK3Ax3>; Wed, 29 Nov 2000 19:53:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32777 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S132400AbQK3AxM>; Wed, 29 Nov 2000 19:53:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Octal vs. Hex war o' death
Date: 29 Nov 2000 16:22:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9046k7$nrf$1@cesium.transmeta.com>
In-Reply-To: <3A2590C8.34459BF9@echostar.com> <20001129181723.A2765@potty.housenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001129181723.A2765@potty.housenet>
By author:    Jeff Epler <jepler@inetnebr.com>
In newsgroup: linux.dev.kernel
>
> On Wed, Nov 29, 2000 at 04:27:04PM -0700, Ian S. Nelson wrote:
> > c) octals were invented for UNIX file permissions and not
> > programming
> 
> You must be joking.  Read much history of computing?  Or
> alt.folklore.computers?  Octal was very natural for 18- and 36-bit
> machines, after all.
> 

Not to mention that it's still quite natural for a lot of machines.
If you ever look at raw x86 machine code, with it's 3-bit fields,
byteized octal actually makes it quite easy to read.

Octal probably predates hexadecimal, since it fit within the 0-9
digits most people used.  Hex is really the natural choice for
modern power-of-two-width machines, though.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
