Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131993AbRCVMfX>; Thu, 22 Mar 2001 07:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132011AbRCVMfO>; Thu, 22 Mar 2001 07:35:14 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:31238 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S131993AbRCVMfD>; Thu, 22 Mar 2001 07:35:03 -0500
Date: Thu, 22 Mar 2001 04:30:52 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt82c686b  and UDMA(100)
In-Reply-To: <20010322010507.A3170@better.net>
Message-ID: <Pine.LNX.4.30.0103220427580.4116-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to some suggestions I give
more for the record on my problem of getting
ata100 transfer rates:

"hdparm /dev/hda" gives:

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3649/255/63, sectors = 58633344, start = 0

so 32 bit mode and dma are indeed on... and still 11 MB/s.

Thx for all the suggestions!
B.D.

-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html

