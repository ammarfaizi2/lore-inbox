Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbQKCJdb>; Fri, 3 Nov 2000 04:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQKCJdW>; Fri, 3 Nov 2000 04:33:22 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:22544 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129118AbQKCJdP>; Fri, 3 Nov 2000 04:33:15 -0500
Date: Fri, 3 Nov 2000 10:33:07 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: James Simmons <jsimmons@suse.com>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011022312560.14650-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.21.0011031032450.15902-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, James Simmons wrote:

> > Console colors are completely messed up (read: black, I even suspect
> > the font to be corrupt somehow) if switching back to console mode
> > from X (either by quitting or ctrl-alt-fX) in recent 2.4.0-textXX
> > kernels. 2.2.XX do work just fine. Is this a known problem with a
> > known fix?
> 
> How recent of a test kernel. Yes their was a problem with the console
> palette but it is now fixed in the most recent test kernels.

2.4.0-test10-pre5

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
