Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129770AbQLHC4P>; Thu, 7 Dec 2000 21:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbQLHC4F>; Thu, 7 Dec 2000 21:56:05 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:11780 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S129770AbQLHCzy>; Thu, 7 Dec 2000 21:55:54 -0500
Date: Thu, 7 Dec 2000 21:25:03 -0500 (EST)
From: Zhiruo Cao <zhiruo@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
cc: zhiruo@cc.gatech.edu
Subject: who is writing to disk
Message-ID: <Pine.GSU.4.21.0012072119450.9251-100000@lennon.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I found a process constantly writing to disk when I run gnome as desktop 
and while the whole system is idle.  I don't find anything in the log
file, and I don't see anything updated in my home dir or in /tmp.  Does it
sound like bdflush is writing?  But I don't hear the disk access when I
am not running gnome.  

My question then is, is there a (monitoring) tool that can tell me who is
writing to disk?  Or how I configure the kernel to know that?

Thanks!

Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
