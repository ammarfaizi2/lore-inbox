Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSJLDas>; Fri, 11 Oct 2002 23:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSJLDas>; Fri, 11 Oct 2002 23:30:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64211 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262790AbSJLDar>;
	Fri, 11 Oct 2002 23:30:47 -0400
Message-ID: <3DA798B6.9070400@us.ibm.com>
Date: Fri, 11 Oct 2002 20:36:22 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [lart] /bin/ps output
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Man, this looks ugly.  I'm just waiting for Bill Irwin, or Anton to 
trump me, though.

   PID TTY      STAT   TIME COMMAND
     1 ?        S      0:10 init
     2 ?        SW     0:00 [migration/0]
     3 ?        SWN    0:00 [ksoftirqd/0]
     4 ?        SW     0:00 [migration/1]
     5 ?        SWN    0:00 [ksoftirqd/1]
     6 ?        SW     0:00 [migration/2]
     7 ?        RWN    0:00 [ksoftirqd/2]
     8 ?        SW     0:00 [migration/3]
     9 ?        SWN    0:00 [ksoftirqd/3]
    10 ?        SW     0:00 [migration/4]
    11 ?        SWN    0:00 [ksoftirqd/4]
    12 ?        SW     0:00 [migration/5]
    13 ?        SWN    0:00 [ksoftirqd/5]
    14 ?        SW     0:00 [migration/6]
    15 ?        RWN    0:00 [ksoftirqd/6]
    16 ?        SW     0:00 [migration/7]
    17 ?        SWN    0:00 [ksoftirqd/7]
    18 ?        SW     0:00 [events/0]
    19 ?        SW     0:00 [events/1]
    20 ?        SW     0:00 [events/2]
    21 ?        SW     0:00 [events/3]
    22 ?        SW     0:00 [events/4]
    23 ?        SW     0:00 [events/5]
    24 ?        SW     0:00 [events/6]
    25 ?        SW     0:00 [events/7]
    26 ?        SW     0:00 [kswapd0]
    28 ?        SW     0:00 [pdflush]
    27 ?        SW     0:00 [pdflush]
    29 ?        SW     0:00 [aio/0]
    30 ?        SW     0:00 [aio/1]
    31 ?        SW     0:00 [aio/2]
    32 ?        SW     0:00 [aio/3]
    33 ?        SW     0:00 [aio/4]
    34 ?        SW     0:00 [aio/5]
    35 ?        SW     0:00 [aio/6]
    36 ?        SW     0:00 [aio/7]
    37 ?        SW     0:00 [scsi_eh_0]
    38 ?        SW     0:00 [scsi_eh_1]
    39 ?        SW     0:00 [scsi_eh_2]
    40 ?        SW     0:00 [kseriod]
    41 ?        DW     0:00 [kjournald]
   115 ?        SW     0:00 [kjournald]
   116 ?        DW     0:00 [kjournald]
   117 ?        SW     0:00 [kjournald]

-- 
Dave Hansen
haveblue@us.ibm.com

