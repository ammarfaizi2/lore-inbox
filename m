Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261986AbSJDVdx>; Fri, 4 Oct 2002 17:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261985AbSJDVdx>; Fri, 4 Oct 2002 17:33:53 -0400
Received: from [166.90.172.6] ([166.90.172.6]:2336 "EHLO
	Mail.Linux-Consulting.com") by vger.kernel.org with ESMTP
	id <S261981AbSJDVdt>; Fri, 4 Oct 2002 17:33:49 -0400
Date: Fri, 4 Oct 2002 14:37:49 -0700 (PDT)
From: Alvin Oga <aoga@Maggie.Linux-Consulting.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Illtud Daniel <illtud.daniel@llgc.org.uk>,
       Effrem Norwood <enorwood@effrem.com>,
       Kanoalani Withington <kanoa@cfht.hawaii.edu>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, jbradford@dial.pipex.com,
       jakob@unthought.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup - media
In-Reply-To: <1033735943.31839.12.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021004143424.10481A-100000@Maggie.Linux-Consulting.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi ya alan

yuppers... 

those 320GB disks are not cheap?? but are floating around

- i use backups for "warm swap".... and dont care about it over time sorta
  thing ... need to be able to keep TBs of data online as fast as possible
  ( few minutes ) to restore a dead/hacked box..

- for "fast turn around"... tapes have always been dayz of effort to
  restore  and too much of a headache to keep the tapes and heads clean
  and test it more rigorously than having to test disks 

- you already implicitly trusts disks to hold your data .. till the disk
  dies ... hopefully due to ball bearing/lubricant/heat failure etc

fun stuff

have fun
alvin

On 4 Oct 2002, Alan Cox wrote:

> On Fri, 2002-10-04 at 12:20, Alvin Oga wrote:
> > we can build an 8-drive ( 120GB at $200ea )  or ( 160GB at $300>? each )
> > 1U box...about 0.960 - 1.28 TB each backup server ( 1U ) for under $2,500 in parts
> > +  cost of raid setup/testing is up to the user
> > 	- am thinking the 1.6TB of storage for 10K lira(?) is too much
> > 
> > i prefer disks to backup data.. so that its always a semi-warm backup
> > ( tapes have always been way tooo slow to find a file and to restore 
> 
> The problem with disks is you still have to archive them somewhere, and
> they are bulky. I also dont know what studies are available on the
> degradation of stored disk media over time. 
> 
> Capacity is not a problem, 3ware do a 12 channel sata card, with maxtor
> drives that comes in at 320x12 = 3.5Tb
> 

