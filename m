Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSLIUr2>; Mon, 9 Dec 2002 15:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSLIUr2>; Mon, 9 Dec 2002 15:47:28 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:16158
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S266101AbSLIUr1>; Mon, 9 Dec 2002 15:47:27 -0500
Message-ID: <3DF50274.1020204@rackable.com>
Date: Mon, 09 Dec 2002 12:52:04 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Spacecake <lkml@spacecake.plus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT372 RAID controller
References: <20021208123134.4be342c7.lkml@spacecake.plus.com>	<3DF4E433.5010207@rackable.com> <20021209203338.32e8665f.lkml@spacecake.plus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2002 20:55:05.0508 (UTC) FILETIME=[403F9E40:01C29FC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spacecake wrote:

>Hi,
>
>Thanks for the reply.
>So, i tried the ac patch and now it all works!
>Now all my harddisks are on this controller (CD-ROM and stuff are on the
>original one), i just want to make sure... this is a stable kernel,
>right? And the driver, it's... stable? :)
><frets over prospect of data loss>
>  
>
  I've found the ac kernel to be fairly stable.  Provided you don't 
start selecting some of the new bleedin edge features.  The only issues 
I know with 2.4.20-ac1 were some DRI/AGP issues.  I've got a new of 
systems that are only stable with the ac series.

>In future i'll always try the ac kernel before asking people.
>Will this appear in 2.4.21?
>

  It will be merged at some point in the future.  When is really up to 
the 2.4 maintainer, and Alan.  Currently the ac ide code works better 
than the mainline 2.4 ide code for me.  So I'm all for a merge;-)




