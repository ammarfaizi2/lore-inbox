Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265472AbSKAAj7>; Thu, 31 Oct 2002 19:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKAAj6>; Thu, 31 Oct 2002 19:39:58 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:63498 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S265472AbSKAAjp>; Thu, 31 Oct 2002 19:39:45 -0500
Message-ID: <3DC1D022.79085722@compuserve.com>
Date: Thu, 31 Oct 2002 19:51:46 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>, Hans Reiser <reiser@namesys.com>
Subject: Re: Reiser vs EXT3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David C. Hansen wrote:
> 
> >On Thu, 2002-10-31 at 13:51, Hans Reiser wrote:
> >  
> >
> >>If you want to talk about 2.6 then you should talk about reiser4 not 
> >>reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 for 
> >>30 copies of the linux kernel source code using modern IDE drives and 
> >>modern processors on a dual-CPU box, so I don't think any amount of 
> >>improved scalability will make ext3 competitive with reiser4 for 
> >>performance usages.  
> >>
> >>We haven't had anyone test performance using RAID yet for reiser4, that 
> >>could be fun.
> >>    
> >>
> >
> >I have a 14-drive hardware RAID array on an 8-proc box.  Is that the
> >kind of thing you want testing on?  If you want to send me some testing
> >scripts, I'll run them.  
> >
> >  
> >
> Yes, that would be cool.
> 
> Green, please respond to this email with details for him.


I have access to a 3 drive hw RAID system with dual processors if you'd
like some more testing.  Do you have info on recommended stripe sizes
vs. performance for Reiser using RAID?

-- 
Kevin
