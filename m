Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281527AbRKUAYb>; Tue, 20 Nov 2001 19:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281530AbRKUAYZ>; Tue, 20 Nov 2001 19:24:25 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:44805 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281527AbRKUAYK>;
	Tue, 20 Nov 2001 19:24:10 -0500
Message-Id: <5.1.0.14.0.20011121112153.021f2c70@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Nov 2001 11:24:07 +1100
To: Linux Kernel List <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: [REISERFS TESTING] new patches on ftp.namesys.com:
  2.4.15-pre7
Cc: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Nikita Danilov <Nikita@Namesys.COM>
In-Reply-To: <20011121001127Z281501-17408+16772@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:07 AM 21/11/01 +0100, Dieter =?iso-8859-15?q?N=FCtzel?= wrote:
>Sorry Nikita,
>
>but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
>I've tried it with "old" and "new" (current) N-inode-attrs.patch. But that 
>doesn't matter.
>
>[-]
>IP: routing cache hash table of 8192 buckets, 64Kbytes
>TCP: Hash tables configured (established 262144 bind 65536)
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>reiserfs: checking transaction log (device 08:03) ...
>Using r5 hash to sort names
>ReiserFS version 3.6.25
>VFS: Mounted root (reiserfs filesystem) readonly.
>Freeing unused kernel memory: 208k freed
>"Warning: unable to open an initial console."

Sure you compiled in Virtual Console support, or Serial Console support?


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

