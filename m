Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQKHRmU>; Wed, 8 Nov 2000 12:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbQKHRmK>; Wed, 8 Nov 2000 12:42:10 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:44042 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129190AbQKHRl5>; Wed, 8 Nov 2000 12:41:57 -0500
Date: Wed, 8 Nov 2000 18:41:39 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: James Simmons <jsimmons@suse.com>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011080920070.2704-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.21.0011081839200.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, James Simmons wrote:

> 
> > You didnt read the config, etc. I posted - I dont have DRI - I
> > have an old P100 with 32Megs of ram and an old ATI Mach64 graphics
> > card. There really is nothing unusual with my setup - console
> > garbagling is even without loading the bttv module at all.
> 
> Okay. So it is what I thought it was orginally.

Okay - so its the console subsystem that gets it wrong? Remember
that 2.2.X gets it right - with the same X server. I really
would like to have this fixed in 2.4 - can I do something to
help fixing this? (I'm not familiar with the console subsystem,
neither with the X server)

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
