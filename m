Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273716AbRIQWyZ>; Mon, 17 Sep 2001 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273754AbRIQWyP>; Mon, 17 Sep 2001 18:54:15 -0400
Received: from forge.redmondlinux.org ([209.81.49.42]:56290 "EHLO
	forge.redmondlinux.org") by vger.kernel.org with ESMTP
	id <S273716AbRIQWyC>; Mon, 17 Sep 2001 18:54:02 -0400
Message-ID: <3BA67E95.6090206@cheek.com>
Date: Mon, 17 Sep 2001 15:52:05 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: mrsam@courier-mta.com
CC: linux-kernel@vger.kernel.org
Subject: disregard: Re: ide zip 100 won't mount
In-Reply-To: <Pine.LNX.4.10.10109171434550.9815-100000@forge.redmondlinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, i went into windows *one more time* just to make sure it was still 
working, and not a hardware problem.  well... looks like it doesn't work 
in windows either.  must be hardware.

funny thing it shows up in dmesg and in "My Computer", just can't read 
from it.

Joseph Cheek wrote:

>i've tried 2.4.7-ac10 and 2.4.9-ac10.  same results.  at boot i get:
>
>Sep 17 11:02:48 seattle kernel: ide-floppy driver 0.97.sv
>Sep 17 11:02:48 seattle kernel: hdd: No disk in drive
>Sep 17 11:02:48 seattle kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512
>sector size, 2941 rpm
>
>looks good, right?  but i put a disk in and i get:
>
>Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc =  0, key =
>2, asc = 30, ascq =  0
>Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc = 1b, key =
>2, asc = 30, ascq =  0
>Sep 17 14:36:23 seattle kernel: hdd: No disk in drive
>
>not hardware, as it works in windows on the same machine.
>
>any ideas?
>
>thanks!
>
>joe
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


