Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRKRTsk>; Sun, 18 Nov 2001 14:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKRTsa>; Sun, 18 Nov 2001 14:48:30 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:53030 "EHLO
	c0mailgw13.prontomail.com") by vger.kernel.org with ESMTP
	id <S278428AbRKRTsS>; Sun, 18 Nov 2001 14:48:18 -0500
Message-ID: <3BF81069.A8C89CE0@starband.net>
Date: Sun, 18 Nov 2001 14:47:53 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I turned swap off, and wow!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to /rpoc/meminfo, I still have about 360MB free as well.
Normally when I have 2GB of swap on, I would have about 150MB used.
Interesting!

For a `ps auxww` list:
http://war.htmlplanet.com/log.txt

Running every program I could find on my box.

2:45pm  up  5:13, 128 users,  load average: 1.93, 1.31, 1.25
521 processes: 519 sleeping, 2 running, 0 zombie, 0 stopped
CPU states: 20.0% user,  4.5% system,  0.0% nice, 75.3% idle
Mem:  1029616K av, 1023840K used,    5776K free,       0K shrd,    1248K
buff
Swap:       0K av,       0K used,       0K free                  340872K
cached

        total:    used:    free:  shared: buffers:  cached:
Mem:  1054326784 1048698880  5627904        0  1286144 349425664
Swap:        0        0        0
MemTotal:      1029616 kB
MemFree:          5496 kB
MemShared:           0 kB
Buffers:          1256 kB
Cached:         341236 kB
SwapCached:          0 kB
Active:         400160 kB
Inactive:       559176 kB
HighTotal:      131008 kB
HighFree:         1972 kB
LowTotal:       898608 kB
LowFree:          3524 kB


