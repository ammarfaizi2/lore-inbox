Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbRGROd4>; Wed, 18 Jul 2001 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbRGROdq>; Wed, 18 Jul 2001 10:33:46 -0400
Received: from ecstasy.ksu.ru ([193.232.252.41]:63619 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S267890AbRGROdf>;
	Wed, 18 Jul 2001 10:33:35 -0400
X-Pass-Through: Kazan State University network
Message-Id: <200107181420.SAA19570@ecstasy.ksu.ru>
Content-Type: text/plain;
  charset="us-ascii"
From: Art Boulatov <art@ksu.ru>
Organization: Kazan State University
To: "Ryan C. Bonham" <Ryan@srfarms.com>
Subject: Re: Adaptec 2400A
Date: Wed, 18 Jul 2001 22:20:34 +0400
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A0389F9@FILESERVER.SRF.srfarms.com>
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A0389F9@FILESERVER.SRF.srfarms.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 July 2001 10:58 pm, Ryan C. Bonham wrote:
> Hi,
>
> Has anyone been sucesfull in getting the Adaptec 2400A Raid card to work
> under the 2.4.X Kernel?  I have Redhat 7.1, and have been uncesesfull in
> getting linux to install with support for this card. I have used the Beta
> Drivers(239) from adaptec and my system just locks when loading the
> drivers...  Thanks for any help.

Hi,
just by the way,
I was trying to set up both RAID5 and RAID0 with Adaptec 3400S  ULTRA160 SCSI 
RAID using the driver patch from their site for 2.4 kernel. Everything went 
just FINE.  The driver did what it  was supposed to do and gave  me no 
errors. Except ocasionally, during reboot when the card's BIOS goes through 
initialization it says I have 1-2 drives failed (could be random). I've 
checked I guess everything I could. After the raid rebuild I could install 
and run the system again for days without errors or bad symptoms at all. 
Untill reboot. Not every reboot but _from_time_to_time_ it failed again. 
I did that for several times.
I guess this problem should be forwarded to Adaptec support, but could 
anybody please give some ideas, at least is that a buggy driver or a buggy 
card?

Thanks,
Art.

