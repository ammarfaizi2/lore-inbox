Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQLYAQg>; Sun, 24 Dec 2000 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130010AbQLYAQ1>; Sun, 24 Dec 2000 19:16:27 -0500
Received: from [194.73.73.138] ([194.73.73.138]:40660 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129716AbQLYAQO>;
	Sun, 24 Dec 2000 19:16:14 -0500
Date: Sun, 24 Dec 2000 23:42:47 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: css hang; somewhere between test12 and test13pre4ac2
Message-ID: <Pine.LNX.4.10.10012242340530.666-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Somewhere between test12 and test13pre4ac2 (sheesh the version
numbers.....) CSS on ATAPI DVD ROM drives has stopped working.

Playing a CSS disc (using xine) causes a complete system hang (machine
doesn't ping - sysrq-b still works) on test13pre4ac2.  On test12 it is
still OK.

This is on an Alpha LX164.

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
