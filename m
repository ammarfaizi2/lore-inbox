Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbRFOCbC>; Thu, 14 Jun 2001 22:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261969AbRFOCav>; Thu, 14 Jun 2001 22:30:51 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:33807 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S261894AbRFOCai>; Thu, 14 Jun 2001 22:30:38 -0400
Message-ID: <3B29734A.738A95D5@damncats.org>
Date: Thu, 14 Jun 2001 22:30:34 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-ac14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <20010615022033Z261561-17720+4111@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Hello Alan,
> 
> I see 4.29 GB under shm with your latest try.
> something wrong?

        total:    used:    free:  shared: buffers:  cached:
Mem:  1053483008 431419392 622063616   122880 24387584 260923392
Swap: 394764288        0 394764288
MemTotal:      1028792 kB
MemFree:        607484 kB
MemShared:         120 kB
Buffers:         23816 kB
Cached:         254808 kB
Active:         225536 kB
Inact_dirty:     53208 kB
Inact_clean:         0 kB
Inact_target:       44 kB
HighTotal:      131056 kB
HighFree:         1048 kB
LowTotal:       897736 kB
LowFree:        606436 kB
SwapTotal:      385512 kB
SwapFree:       385512 kB

I don't seem to have the problem...

John
