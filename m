Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284336AbRLBUlM>; Sun, 2 Dec 2001 15:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284345AbRLBUk3>; Sun, 2 Dec 2001 15:40:29 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:11530 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S284343AbRLBUjU>; Sun, 2 Dec 2001 15:39:20 -0500
Date: Sun, 2 Dec 2001 20:39:14 +0000
From: Alan Ford <alan@whirlnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Another 2.4.17-pre2 problem
Message-ID: <20011202203914.A653@whirlnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to my last problem with -pre2, I went to reboot to send the
mail (pcmcia modem), and when it shut down and went to "Unmouting local
filesystems" it said "/dev/hda7 not mounted" (which is my root filesystem).

And on bootup back to 2.4.16-pre1 it said /dev/hdb7 had not been cleanly
unmounted so it fscked it.

Odd.

-- 
Alan Ford * alan@whirlnet.co.uk 
