Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261588AbSJDMkl>; Fri, 4 Oct 2002 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSJDMkk>; Fri, 4 Oct 2002 08:40:40 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:28407 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261583AbSJDMkj>; Fri, 4 Oct 2002 08:40:39 -0400
Subject: Re: RAID backup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alvin Oga <aoga@Maggie.Linux-Consulting.com>
Cc: Illtud Daniel <illtud.daniel@llgc.org.uk>,
       Effrem Norwood <enorwood@effrem.com>,
       Kanoalani Withington <kanoa@cfht.hawaii.edu>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, jbradford@dial.pipex.com,
       jakob@unthought.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1021004041421.5688A-100000@Maggie.Linux-Consulting.com>
References: <Pine.LNX.3.96.1021004041421.5688A-100000@Maggie.Linux-Consulting.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 13:52:23 +0100
Message-Id: <1033735943.31839.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 12:20, Alvin Oga wrote:
> we can build an 8-drive ( 120GB at $200ea )  or ( 160GB at $300>? each )
> 1U box...about 0.960 - 1.28 TB each backup server ( 1U ) for under $2,500 in parts
> +  cost of raid setup/testing is up to the user
> 	- am thinking the 1.6TB of storage for 10K lira(?) is too much
> 
> i prefer disks to backup data.. so that its always a semi-warm backup
> ( tapes have always been way tooo slow to find a file and to restore 

The problem with disks is you still have to archive them somewhere, and
they are bulky. I also dont know what studies are available on the
degradation of stored disk media over time. 

Capacity is not a problem, 3ware do a 12 channel sata card, with maxtor
drives that comes in at 320x12 = 3.5Tb

