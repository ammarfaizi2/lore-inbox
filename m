Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSJF7>; Sun, 19 Nov 2000 04:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKSJFt>; Sun, 19 Nov 2000 04:05:49 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:34564 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129136AbQKSJFh>; Sun, 19 Nov 2000 04:05:37 -0500
Date: Sun, 19 Nov 2000 00:35:25 -0800
Message-Id: <200011190835.eAJ8ZPb07069@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATA/IDE: dmaproc error 14 testers wanted!
In-Reply-To: <Pine.LNX.4.10.10011181220390.17557-100000@master.linux-ide.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000 12:23:05 -0800 (PST), Andre Hedrick <andre@linux-ide.org> wrote:
> 
> If anyone is suffering from the dreaded "dmaproc error 14: unsupported"
> error and want to test a code that could get you out of that deadlock
> please speak up.
> 
> Basically this is an Intel 440BX PIIX4 issues, but the solution is global
> and should work for all cases.

Interestingly enough, I get it on a VIA MVP3 with 2.2.18pre + bkz's patch.
Since it's eaten two filesystems by now, I'm not overly eager to play
with it again... On a second thought though, I'd rather play with it now
in a controlled environment, so feel free to send the patch my way.

If you want details, just ask.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
