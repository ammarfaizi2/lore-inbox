Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136568AbREGSZ2>; Mon, 7 May 2001 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136560AbREGSZT>; Mon, 7 May 2001 14:25:19 -0400
Received: from [24.219.123.216] ([24.219.123.216]:772 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136522AbREGSZJ>; Mon, 7 May 2001 14:25:09 -0400
Date: Mon, 7 May 2001 11:25:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: David Balazic <david.balazic@uni-mb.si>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Hotswap ATA status ?
In-Reply-To: <3AF6D15B.7A403EE2@uni-mb.si>
Message-ID: <Pine.LNX.4.10.10105071112030.378-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, David Balazic wrote:

> 
> Andre , you promised ATA/IDE hot-swap on "normal" hardware
> several weeks ( months ? ) ago. What happened ?
> 
> -- 
> David Balazic
> --------------
> "Be excellent to each other." - Bill & Ted
> - - - - - - - - - - - - - - - - - - - - - -
> 

Well lets see.....

I lost my ISP (NorthPoint + PacBell)			4/18/2001
There was a T13 meeting the following week.		4/23/2001
Found a flaw in the tests of writecaching.
Reverified the contents of the CODE base to match SPEC	4/29/2001

Reverified that certain hosts are not good.
(oh two kids that were ill and then the wife)
Reconfigure the "CAVE" where I do all of my work.
Write 90% of 48-bit LBA, use/test the hostswap for large/huge drives.  
Look at the user API and chuckled then cried and roared aloud......
Figure out License for the "ide-service.o" module.
	It will not be GPL but a very strict LAD (BSD-ish) License.
	Reasons will follow, but I will not be liable for stupid usage.

So if you are reallying dying to test code that has not been full shaken
down and requires a huge page for the glue, I will post one.

The service utility is not ready yet so it is no good without one.

Regards,

Andre Hedrick
Linux ATA Development

PS I left a dump here and there.........but that was going to be WTMI

