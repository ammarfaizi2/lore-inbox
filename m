Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131929AbRAPVJD>; Tue, 16 Jan 2001 16:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131940AbRAPVIz>; Tue, 16 Jan 2001 16:08:55 -0500
Received: from gnwy29.wuh.wustl.edu ([128.252.22.29]:21514 "EHLO
	gnwy29.wuh.wustl.edu") by vger.kernel.org with ESMTP
	id <S131929AbRAPVIq>; Tue, 16 Jan 2001 16:08:46 -0500
Date: Tue, 16 Jan 2001 15:11:01 -0600 (CST)
From: "Rodney M. Jokerst" <rmjokers@gnwy29.wuh.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Problem:  Blank screen in X after heavy disk access (2.4 only)
Message-ID: <Pine.LNX.4.21.0101161503310.24100-100000@gnwy29.wuh.wustl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all of the late 2.3 kernels, 2.4 test kernels, and the latest
official 2.4.0 kernel that I have tried, I get disturbing behavior during
and after heavy disk access, such as uploading a 500MB file from the local
network.  This action causes my screen to go blank in X and remain blank
unless I move the mouse or type on the keyboard.  The second I stop doing
one of these activities, it goes blank again.  While it is blank, it seems
to be flashing every second, as if it is recieving blank screen commands
repeatedly.  This behavior continues until I restart the machine.  If I
switch to a console, everything is fine.  If I restart the X server, the
behavior continues.  I have never seen this behavior in any of the 2.2
series of kernels, including 2.2.18 which I am running now.  If anyone is
interested in this problem, I can get all of the relevant hardware and
software info for my computer.  Just let me know what I need to provide.

thanks,

Rodney M. Jokerst

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
