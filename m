Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315736AbSEJA0H>; Thu, 9 May 2002 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315737AbSEJA0G>; Thu, 9 May 2002 20:26:06 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:44437 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S315736AbSEJA0E> convert rfc822-to-8bit; Thu, 9 May 2002 20:26:04 -0400
Date: Thu, 9 May 2002 20:25:58 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: >12 drives in a RAID?
In-Reply-To: <20020509175256.A31674@mail.harddata.com>
Message-ID: <Pine.LNX.4.44.0205092019480.5701-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Roy & All ,  Mr. Neil Brown <neilb@cse.unsw.edu.au>
	Has come up with a (somewhat) complete tool for software raid
	maintenance .  Also might try raising these questions & concerns
	on the linux-raid list .  Please see below .  Hth ,  JimL

	http://www.cse.unsw.edu.au/~neilb/source/mdadm/

On Thu, 9 May 2002, Michal Jaegermann wrote:
> On Thu, May 09, 2002 at 04:16:56PM +0200, Jakob Østergaard wrote:
> > On Thu, May 09, 2002 at 04:11:00PM +0200, Roy Sigurd Karlsbakk wrote:
> > > hi
> > > How can I use more than 12 drives in a RAID config? I need it!!!
> > > Please cc: to me as I'm not on the list(s)
> > Yes.
> >
> > Back in the "old days" with the old superblocks you couldn't.
> Hm, the last time I looked a header used by kernels had space
> for someting like 27 or 29 drives (I do not remember the exact
> number) but its variant in 'raidtools' sources allowed indeed
> only 12.  Synchronizing those headers to kernel values raised
> a maximum number of disks in an array quite considerably.
>   Michal

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+



