Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKIJff>; Thu, 9 Nov 2000 04:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKIJfY>; Thu, 9 Nov 2000 04:35:24 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:5391 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129033AbQKIJfW>; Thu, 9 Nov 2000 04:35:22 -0500
Date: Thu, 9 Nov 2000 10:34:59 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: James Simmons <jsimmons@suse.com>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011081017320.2704-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.21.0011091033220.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, James Simmons wrote:

> 
> > Sure - but this was always the case. And using 2.2 with the same
> > (or more) stress the Xserver is still able to set the video hardware
> > back to vga text mode. I just want to know whats the difference
> > between 2.2 and 2.4 that causes failure in 2.4.
> 
> I don't think it is the console system. I bet if you stress 2.2 even more
> you will get the same results.

Ok, obviously I'm not happy with this - I'll try to stress 2.2, but
it never happened there. With 2.4 its nearly _always_ the case (on
32Megs ram you get into swapping very fast with X and gnome) - so, to
repeat, I'm not happy with the current 2.4 situation.

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
