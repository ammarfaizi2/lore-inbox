Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBJVSP>; Sat, 10 Feb 2001 16:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129084AbRBJVSF>; Sat, 10 Feb 2001 16:18:05 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:18029 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129072AbRBJVSA>; Sat, 10 Feb 2001 16:18:00 -0500
Message-ID: <3A85AFC8.9070107@blue-labs.org>
Date: Sat, 10 Feb 2001 13:16:56 -0800
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre11 i686; en-US; m18) Gecko/20010208
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Daniel Stone <daniel@kabuki.eyep.net>, Chris Mason <mason@suse.com>,
        David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14RbJG-0001ds-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> I run Reiser on all but /boot, and it seems to enjoy corrupting my
>> mbox'es randomly.
>> Using the old-style Reiser FS format, 2.4.2-pre1, Evolution, on a CMD640
>> chipset with the fixes enabled.
>> This also occurs in some log files, but I put it down to syslogd
>> crashing or something.
> 
> 
> Before you put that down to reiserfs can you chek 2.4.2-pre2. It may be
> problems below the reiserfs layer


Just as an aside, I've watched this conversation go on and on while I 
run reiserfs on several servers, workstations, and a notebook.  I have 
current kernels and have watched carefully for corruption.  I haven't 
seen any evidence of corruption on any of them including my notebook 
which has a bad battery and bad power connection so it tends to 
instantly die.

Alan, is there a particular trigger to this?

-d

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
