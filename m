Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130688AbQKHJbN>; Wed, 8 Nov 2000 04:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbQKHJax>; Wed, 8 Nov 2000 04:30:53 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:38151 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130688AbQKHJau>; Wed, 8 Nov 2000 04:30:50 -0500
Date: Wed, 8 Nov 2000 10:30:34 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@suse.com>,
        Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        tytso@mit.edu, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <E13tDHs-0007cs-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011081029260.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Alan Cox wrote:

> > Actually I just thought about it. Do you DRI running. When you have DRI
> > enabled you shouldn't VT switch. It is a design flaw in DRI and the
> > console system :-(. Disable DRI you you will be fine.
> 
> The theory behind DRI covers this fine. If its breaking fix the bugs in the
> Xserver and DRI code. X gets to pick when it gives the console back

You didnt read the config, etc. I posted - I dont have DRI - I
have an old P100 with 32Megs of ram and an old ATI Mach64 graphics
card. There really is nothing unusual with my setup - console
garbagling is even without loading the bttv module at all.

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
