Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131981AbRCVKaT>; Thu, 22 Mar 2001 05:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRCVKaK>; Thu, 22 Mar 2001 05:30:10 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:30214 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S131966AbRCVK3z>; Thu, 22 Mar 2001 05:29:55 -0500
Date: Thu, 22 Mar 2001 02:25:45 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt82c686b  and UDMA(100)
In-Reply-To: <20010322010507.A3170@better.net>
Message-ID: <Pine.LNX.4.30.0103220224160.3867-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And for the record:

"hdparm -d1 -t -X69 /dev/hda" gives:

/dev/hda:
 setting using_dma to 1 (on)
 setting xfermode to 69 (UltraDMA mode5)
 using_dma    =  1 (on)
 Timing buffered disk reads:  64 MB in  5.64 seconds = 11.35 MB/sec

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

