Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbRBCQ5z>; Sat, 3 Feb 2001 11:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130305AbRBCQ5p>; Sat, 3 Feb 2001 11:57:45 -0500
Received: from [195.154.83.81] ([195.154.83.81]:30993 "EHLO netgem.com")
	by vger.kernel.org with ESMTP id <S129979AbRBCQ5h>;
	Sat, 3 Feb 2001 11:57:37 -0500
From: Jocelyn Mayer <jocelyn.mayer@netgem.com>
To: rct@gherkin.sa.wlk.com, linux-kernel@vger.kernel.org
Message-ID: <3A7C37FD.6050901@netgem.com>
Date: Sat, 03 Feb 2001 17:55:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010119
X-Accept-Language: en, fr
MIME-Version: 1.0
Subject: Re: ATAPI CD burner with cdrecord > 1.6.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel version is 2.4.1. For versions of cdrecord later than 1.6.1
> (1.8.1 through the latest 1.10 alpha verified), attempting to burn a
> CD results in a SCSI error of some kind. Here's some representative
> output from a "dummy" burn session with cdrecord-1.9: 

> As I recall, things work just fine with a real SCSI CD burner, so I
> think this behavior is limited to the ide-scsi flavor of things. If
> anyone has a clue as to what's really happening here, a fix or workaround
> would be appreciated. In the meantime, I'll continue to use the older
> software (xcdroast-0.96e with cdrecord-1.6.1). Thanks! 

Well...
Maybe I'm not a lucky guy,
but I just got the same trouble with a real SCSI burner...
This one is a Yamaha 8416,
attached to a Tekram UW controleur.
The error I got is exactly the same.
I got this since kernel version 2.4.0-test12, I think.

Jocelyn Mayer
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
