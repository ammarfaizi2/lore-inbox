Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBGLIU>; Wed, 7 Feb 2001 06:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRBGLIK>; Wed, 7 Feb 2001 06:08:10 -0500
Received: from r2-pc.dcs.qmw.ac.uk ([138.37.88.145]:36245 "EHLO r2-pc")
	by vger.kernel.org with ESMTP id <S129055AbRBGLIE>;
	Wed, 7 Feb 2001 06:08:04 -0500
Date: Wed, 7 Feb 2001 11:07:57 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: increasing the 512 process limit at run-time?
Message-ID: <Pine.LNX.4.33.0102071059540.8811-100000@r2-pc>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I note that include/linux/tasks.h contains #define NR_TASKS 512

Can I tune this at run-time? My lovely server's been up since the day
2.2.16 was released, and now having hit the limit I don't want to reboot :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
