Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRIJKDU>; Mon, 10 Sep 2001 06:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269404AbRIJKDL>; Mon, 10 Sep 2001 06:03:11 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:56836 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269318AbRIJKC7>; Mon, 10 Sep 2001 06:02:59 -0400
Message-ID: <3B9C8B60.7191EFFF@t-online.de>
Date: Mon, 10 Sep 2001 11:44:00 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: psusi@cfl.rr.com, linux-kernel@vger.kernel.org
Subject: Re: New SCSI subsystem in 2.4, and scsi idle patch
In-Reply-To: <1000076015.18039.1.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love schrieb:
> 

(..details...)
 
> Finally, I like your idea.  I have an all SCSI system and would like my
> disks to spin down. Good luck.

I can only agree!
I sleep near a 4-disk-box, and it would be nice if i could spin down the
disks at night...:-)

At the times of 2.0.xy, i also played around with the
"scsi-idle"-package and it worked quite well...but i noticed one effect:
Since i used it the first time, one of my disks spinned down
randomly....it stayed then still for about 10secs and started again...it
had no effect on the system (not even a logentry), but it costed me a
CD-R one time, and so i stopped using "scsi-idle".

I dont know if this was disk-dependant (the disk died some weeks ago
after working for about 3 years, it could have been defect), but it
started after the first use of "scsi-idle"...

But i would be glad to test a new version of "scsi-idle", if you write
one...:-)

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
