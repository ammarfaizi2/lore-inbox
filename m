Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSAHBbT>; Mon, 7 Jan 2002 20:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287447AbSAHBbJ>; Mon, 7 Jan 2002 20:31:09 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7697 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287439AbSAHBbA>; Mon, 7 Jan 2002 20:31:00 -0500
Date: Mon, 7 Jan 2002 17:27:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: U133/48-bit (IDE command queueing. (fwd))
Message-ID: <Pine.LNX.4.10.10201071726460.31309-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not doable w/o infrastructure of patch.

---------- Forwarded message ----------
Date: Tue, 18 Dec 2001 08:51:50 +1300
From: Stuart W <stuartw@kcbbs.gen.nz>
To: andre@linux-ide.org
Subject: IDE command queueing.


Greetings from New Zealand.

to cut to the chase, I just though I'd point out:
http://www.storagereview.com/jive/sr/thread.jsp?forum=5&thread=20936
most specifically, the mention of some IBM IDE drives doing command queing.

I'm sure you know about this (much more than I do), however I was wondering 
if the current linux IDE implementation can take advantage of this? 

I'm a VERY strong proponent of both IDE and Linux, which as I'm sure you know 
is an up hill battle against many SCSI bigots.. Many of them can't see beyond 
the $ signs that they think mean SCSI must be better.

I'm truly impressed with the latest 2.4 kernels, and have seen some major 
performance improvements under IDE, but I am hoping for more.

I find it interesting that such sited as storage review only do windows 
testing, even for 'server' products, completely ignoring the fact that the 
host OS can have a major effect on driver performance, and that windows is 
not nescessarily the best in these cases.

Anyway, I hope perhaps there is something usefull to you in the above link.

Regards,
Stuart.

