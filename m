Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRFOCUq>; Thu, 14 Jun 2001 22:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbRFOCUg>; Thu, 14 Jun 2001 22:20:36 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:45756 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261561AbRFOCUc>; Thu, 14 Jun 2001 22:20:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.5-ac14
Date: Fri, 15 Jun 2001 04:33:22 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010615022033Z261561-17720+4111@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I see 4.29 GB under shm with your latest try.
something wrong?

Regards,
	Dieter

SunWave1>cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  327802880 322592768  5210112 4294184960  8417280 253640704
Swap: 1052794880 95768576 957026304
MemTotal:       320120 kB
MemFree:          5088 kB
MemShared:    4294966532 kB
Buffers:          8220 kB
Cached:         247696 kB
Active:         228008 kB
Inact_dirty:     24552 kB
Inact_clean:      2592 kB
Inact_target:      468 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       320120 kB
LowFree:          5088 kB
SwapTotal:     1028120 kB
SwapFree:       934596 kB

