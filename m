Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130955AbRBXAgG>; Fri, 23 Feb 2001 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbRBXAf5>; Fri, 23 Feb 2001 19:35:57 -0500
Received: from [209.250.53.154] ([209.250.53.154]:29958 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S130955AbRBXAft>; Fri, 23 Feb 2001 19:35:49 -0500
Date: Fri, 23 Feb 2001 18:37:43 -0600
From: Steven Walter <srwalter@yahoo.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.2 broke gcd (or, audio CD's won't play)
Message-ID: <20010223183743.A26519@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 6:13pm  up 1 day, 26 min,  1 user,  load average: 1.08, 1.03, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to 2.4.2, gcd or any audio CD player will work.  The
attached chunk of dmesg is the messages produced by attempting to play
them.  The player just loops through all tracks, playing nothing.
Ripping CD's a la cdparanoia still works.

If its any consequence, my CD-ROM is now detected as a CD-ROM/DVD-ROM.
Is this also a problem, or merely an optimization in the boot-detection
routines?

Thanks
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
