Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129731AbRBBVTv>; Fri, 2 Feb 2001 16:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbRBBVTc>; Fri, 2 Feb 2001 16:19:32 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:28932 "EHLO devel.uklinux.net")
	by vger.kernel.org with ESMTP id <S129810AbRBBVT1>;
	Fri, 2 Feb 2001 16:19:27 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 2 Feb 2001 21:21:09 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Every Make option ends in error.
In-Reply-To: <Pine.LNX.4.10.10102021608570.6971-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0102022118001.31744-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Mark Hahn wrote:

> >  I guess I'm doing something stupid, so please can somebody point it out
> > and put me out of my misery ?
> 
> don't use cp to copy kernel trees unless you use -s.
> 
Thanks for the advice, Mark. I'll give it a go in a minute (got to log off
this box and connect the monitor to the test box). I figured that since
I've got a 1.5Gb partition for kernels, putting a third one in there
wouldn't cause any grief.
Ken

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
