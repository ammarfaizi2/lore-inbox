Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313261AbSC1VXh>; Thu, 28 Mar 2002 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313263AbSC1VX1>; Thu, 28 Mar 2002 16:23:27 -0500
Received: from a0q03.ami.com.au ([203.55.31.107]:17675 "EHLO
	dugite.os2.ami.com.au") by vger.kernel.org with ESMTP
	id <S313261AbSC1VXO>; Thu, 28 Mar 2002 16:23:14 -0500
Message-Id: <200203282059.g2SKxCc20791@numbat.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Mark Lord <mlord@pobox.com>
cc: Bill Davidsen <davidsen@tmr.com>, John Summerfield <summer@os2.ami.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        summer@numbat.Os2.Ami.Com.Au
Subject: Re: IDE and hot-swap disk caddies 
In-Reply-To: Message from Mark Lord <mlord@pobox.com> 
   of "Thu, 28 Mar 2002 13:10:55 EST." <3CA35CAF.59B20386@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Mar 2002 04:59:12 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mlord@pobox.com said:
>  -x   perform device for hotswap flag (0/1) (DANGEROUS) 

I got 4.6 from rawhide; -x isn't in the man page.
[summer@numbat summer]$ man hdparm | grep -w x
[summer@numbat summer]$ man hdparm | grep -w X
              good  idea to use the appropriate -X option in com-
       -X     Set the IDE transfer  mode  for  newer  (E)IDE/ATA2
              drives which support alternate transfer  modes,  -X
[summer@numbat summer]$
-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.

==============================
If you don't like being told you're wrong,
	be right!



