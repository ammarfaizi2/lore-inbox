Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRBPQDx>; Fri, 16 Feb 2001 11:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbRBPQDd>; Fri, 16 Feb 2001 11:03:33 -0500
Received: from tux17.cs.wisc.edu ([128.105.111.117]:50692 "EHLO
	tux17.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S130516AbRBPQDb>; Fri, 16 Feb 2001 11:03:31 -0500
Date: Fri, 16 Feb 2001 10:03:31 -0600 (CST)
From: Matthew McCormick <mattmcc@cs.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: write system call location
Message-ID: <Pine.LNX.3.96L.1010216100247.2507G-100000@tux17.cs.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to find the source code for the write system call.
I've checked through all the source code for the kernel and looked around
on the mailling list but can't seem to find it anywhere.  I was tracing
the file system operations and reached the function sys_write (which calls
write).  Any help would be greatly appreciated.  I don't belong to the
mailing list so please CC me on the answer.  My e-mail is:

mattmcc@cs.wisc.edu

Thank you for the help.

Matt McCormick


