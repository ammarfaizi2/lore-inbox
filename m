Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbRFZMmz>; Tue, 26 Jun 2001 08:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264911AbRFZMmp>; Tue, 26 Jun 2001 08:42:45 -0400
Received: from ppp80.dyn141.pacific.net.au ([210.23.141.80]:36881 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S264910AbRFZMmj>; Tue, 26 Jun 2001 08:42:39 -0400
Date: Tue, 26 Jun 2001 22:42:31 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: nonzero shared ram and 2.4.x
Message-ID: <20010626224231.C649@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it wasn't meant to try and count it:

0 [22:40:59] bowman@europa:/home/bowman>> uname -a
Linux europa 2.4.5-ac9 #4 Wed Jun 13 12:54:18 EST 2001 i686 unknown
0 [22:41:29] bowman@europa:/home/bowman>> more /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  260530176 228261888 32268288    65536 31141888 51003392
Swap: 270499840        0 270499840
MemTotal:       254424 kB
MemFree:         31512 kB
MemShared:          64 kB
Buffers:         30412 kB
Cached:          49808 kB
Active:          65848 kB
Inact_dirty:     14436 kB
Inact_clean:         0 kB
Inact_target:       24 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254424 kB
LowFree:         31512 kB
SwapTotal:      264160 kB
SwapFree:       264160 kB

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

