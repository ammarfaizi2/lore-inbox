Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbRASBo2>; Thu, 18 Jan 2001 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbRASBoE>; Thu, 18 Jan 2001 20:44:04 -0500
Received: from rosemary.cs.adelaide.edu.au ([129.127.8.221]:23766 "EHLO
	rosemary.cs.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S129765AbRASBnz>; Thu, 18 Jan 2001 20:43:55 -0500
Date: Fri, 19 Jan 2001 12:13:49 +1030 (CST)
From: gsdrahei@xenon.cs.adelaide.edu.au
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Modifying TCP implementation in Linux Kernel?
Message-ID: <Pine.SOL.4.21.0101181623030.8948-100000@xenon.cs.adelaide.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working a research project along with a couple of other guys at
University of Adelaide on optimising the congestion control scheme to
improve performance.

We are looking at modifying the TCP implementation in the linux Kernel, in
order to take some measurments of the performance of the current
implementation, and then look at what optimisations can be made to the
congestion control strategies to improve performance.

Are there any resources or online documents available about the Linux TCP
implementation? I've looked around the web, and in the Kernal Source tree,
and can't seem to find much.

What is the best way to log information? Are there any builtin logging
functions in the Kernel? If so, are there any documents on the use of
these? Or will we have to use tcpdump, and add traces
into the Kernel. Obviously any traces should be buffered to memory, and
then written out at the conclusion of the tests. 

cheers,

Geraint Draheim


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
