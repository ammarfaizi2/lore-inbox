Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313810AbSDZKgW>; Fri, 26 Apr 2002 06:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313815AbSDZKgV>; Fri, 26 Apr 2002 06:36:21 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:59041 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313810AbSDZKgV>; Fri, 26 Apr 2002 06:36:21 -0400
Date: Fri, 26 Apr 2002 12:16:56 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <Pine.LNX.3.96.1020424150911.3065D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0204261213570.27505-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Bill Davidsen wrote:
> > Put your CDs on a different controller and you can do anything you
> > want without affecting other tasks.
> 
>   As above, another type of bus is not cost effective, another IDE cable
> doesn't solve the problem, no matter what theory says. 

Hmm, i have my cdrw on a different IDE controller in an all IDE system and 
never experience "hangs" even for completely borked cds. The disks are on 
the onboard IDE controller. This is also true for when burning CDs, i can 
thrash the harddisks with no noticeable slowdown.

	Zwane
-- 
http://function.linuxpower.ca
		

