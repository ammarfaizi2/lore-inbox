Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265183AbSJRPuX>; Fri, 18 Oct 2002 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265194AbSJRPuX>; Fri, 18 Oct 2002 11:50:23 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:57245 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S265183AbSJRPuV>; Fri, 18 Oct 2002 11:50:21 -0400
Date: Fri, 18 Oct 2002 16:56:17 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: dbarrera@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Machine hang - OOPS
Message-ID: <Pine.GSO.4.44.0210181653050.22210-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My machine 'hanged' last night while running	the Database Opensource
   Test
>   Suite (DOTS) with DB2 on a standard Red Hat Linux release 7.3
   (Valhalla),
>    Kernel 2.4.18-3bigmem on an i686 installation. The machine appears
   hang,
>   although it replies to a ping.

Just before Alan says it :-)

There have been 4 errata kernels released for RH 7.3 so far, so you
really ought to upgrade to the latest of those for starters. Obviously,
your problem may not be easily reproducible, but if you _could_
reproduce it on the latest kernel, I think people would take a higher
level of interest! Just my advice....

Cheers
Alastair                            .-=-.
__________________________________,'     `.
                                           \   www.mrc-bsu.cam.ac.uk
Alastair Stevens, Systems Management Team   \       01223 330383
MRC Biostatistics Unit, Cambridge UK         `=.......................

