Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRAaOvW>; Wed, 31 Jan 2001 09:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131836AbRAaOvM>; Wed, 31 Jan 2001 09:51:12 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:61331 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131658AbRAaOvG>;
	Wed, 31 Jan 2001 09:51:06 -0500
Date: Wed, 31 Jan 2001 09:51:02 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: archan <devrootp@bigfoot.com>
cc: Prasanna P Subash <psubash@turbolinux.com>,
        Matthew Gabeler-Lee <msg2@po.cwru.edu>, <linux-kernel@vger.kernel.org>,
        AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1 PAL_BG
In-Reply-To: <3A77D3F1.4070206@bigfoot.com>
Message-ID: <Pine.SGI.4.31L.02.0101310950000.1024091-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, archan wrote:

> I am using "Pixel View TV tuner card" based on "bttv". It works perfect
> in Windows with default TV application, and also responding well in
> Linux 2.2.17 and 2.4.0-test10 kernel. The device is getting detected
> perfectly by 2.4 kernel but I could not be able to check whether the
> card in 2.4 kernel is responding on PAL-BG signal (here, my frequency
> table is PAL-BG, country India) as none of the Linux apps (xawtv,
> cabletv) are responding positively.

I think I ended up trying the bttv 0.8 drivers, and maybe video4linux2,
nowe that I think about it.

I'll have to doublecheck and get back to you on that.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
