Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293381AbSCFJMO>; Wed, 6 Mar 2002 04:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293393AbSCFJME>; Wed, 6 Mar 2002 04:12:04 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:9385 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293379AbSCFJLw>; Wed, 6 Mar 2002 04:11:52 -0500
Date: Wed, 6 Mar 2002 10:56:56 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16iQPg-00058v-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203061055070.2839-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is that reference, chances are there are more non vocal people using 
the interface than what you read on LKML.

---------- Forwarded message ----------
Date: 21 Jan 2002 17:46:13 -0500
From: John Zedlewski <zedlwski@Princeton.EDU>
To: linux-kernel@vger.kernel.org
Subject: IDE patch + Taskfile

Like everybody else, I wanted to chime in about my happiness with the
IDE patch (I'm using it via the 2.4.18-pre3-mjc patch collection). Works
beautifully on my laptop with an IBM Travelstar (DJSA-220) and an
IDE-interface IBM microdrive (via a compactflash adapter).

But I also wanted to REALLY thank Andre and friends for the new TASKFILE
ioctl. I'm doing a lot of low-level performance testing on the
Microdrive and the old ioctl interface was completely inadequate. For
instance, several of the CFA_* IDE commands were unusable from userspace
before taskfile came along and now they're a snap... 

Thanks again!
--JRZ


