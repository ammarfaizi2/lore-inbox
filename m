Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262332AbSJDSx7>; Fri, 4 Oct 2002 14:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbSJDSx7>; Fri, 4 Oct 2002 14:53:59 -0400
Received: from hokua.cfht.hawaii.edu ([128.171.80.51]:12508 "EHLO
	hokua.cfht.hawaii.edu") by vger.kernel.org with ESMTP
	id <S262320AbSJDSx5>; Fri, 4 Oct 2002 14:53:57 -0400
Message-ID: <3D9DE4E6.7070800@cfht.hawaii.edu>
Date: Fri, 04 Oct 2002 08:58:46 -1000
From: Kanoalani Withington <kanoa@cfht.hawaii.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Illtud Daniel <illtud.daniel@llgc.org.uk>
CC: Effrem Norwood <enorwood@effrem.com>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, jbradford@dial.pipex.com,
       jakob@unthought.net, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup
References: <CFEAJJEGMGECBCJFLGDBCENHCEAA.enorwood@effrem.com> <3D9D6C84.F1736E15@llgc.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Illtud Daniel wrote:

>Effrem Norwood wrote:
>
>>In addition, HSM software costs
>>something (even if you write it yourself) on top of the tape infrastructure.
>>One customer of ours was quoted 40K per TB of HSM *software* alone.
>>
>
>I've got 25TB uncompressed of HSM here, and it's cost us (ex VAT)
>roughly:
>
>£10k for the first 1.6TB (on NT, DLT library)
>£18k for the next  6.0TB (on NT, LTO library)
>£45k for the next 18.0TB (on Solaris, LTO Library)
>
>...for the software licencing alone. Plus about 10% pa. in support
>costs.
>You're looking at about 50-60% of the library cost for the HSM software
>to manage it (tapes are another thing). Is HSM really that difficult?
>
>It really is a racket, but it's not so much compared with the
>cost of re-producing the data (mainly digitized collections).
>I'd be happier about it if they were more reliable (libs and s/w).
>Disk arrays, on the other hand, would cost us a fortune in
>upgrading the cooling - we've had to do this once just because of
>the 3-4 TB of online storage we've got, and adding huge exchangers
>(and associated pipes) isn't something I want to do much of.
>
I agree it's a total racket. I've spent an appalling amount of money on 
this stuff over the years considering how simple it is. Last year I 
finally built mtx, the open source tape library driver, and wrote my own 
software in tcl scripts for a new archiving system. It really is that 
simple, I don't know how they can charge so much for thier software, 
especially when some it is junk to begin with.

-Kanoa

>
>
>Oh, and having spent much of last night and this morning dealing
>with multiple SCSI disk failures, and having seen about 5% of
>ours fail in a year, I'm rapidly seeing the light on IDE.
>


