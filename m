Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSDVRpn>; Mon, 22 Apr 2002 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSDVRpm>; Mon, 22 Apr 2002 13:45:42 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:22283 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S314339AbSDVRpk>;
	Mon, 22 Apr 2002 13:45:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Mon, 22 Apr 2002 19:45:09 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: BK, deltas, snapshots and fate of -pre...
CC: Larry McVoy <lm@bitmover.com>, Ian Molton <spyro@armlinux.org>,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <31CB8B22019@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Apr 02 at 19:34, Daniel Phillips wrote:
> 
> True, but I'm a contributor and so I have an interest in it.  It would be
> better if you didn't pursue that line of argument.
> 
> How about the URL?

Why we have kernel tarball at all, then? Just put URLs where you can 
download different pieces of kernel, and we are done. You finally
solved problem how to help users who do not want to download different
arch subdirectories, or different drivers, as they do not need them
for their hardware, and downloading them takes a precious time.

As there is definitely at least one developer who uses Bitkeeper, and
as this information is seen useful at least by some people (me including),
I see no reason why this information should not be part of kernel.

Otherwise we must remove ncpfs and matroxfb from the kernel immediately, as
they both use proprietary protocol/interface, and there is available only 
one vendor on the world who provides/supports this protocol/interface 
(Novell resp. Matrox), and matroxfb documentation is just hidden advertising
of Matrox corp.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
