Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbTL0Fpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 00:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbTL0Fpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 00:45:43 -0500
Received: from [64.65.177.98] ([64.65.177.98]:25075 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S265328AbTL0Fpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 00:45:41 -0500
Subject: Re: 3ware driver broken with 2.4.22/23 ?
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@3ware.com
In-Reply-To: <3FE645E3.30602@rackable.com>
References: <20031221112113.GE916@mail.muni.cz>
	 <3FE645E3.30602@rackable.com>
Content-Type: text/plain
Message-Id: <1072503925.27022.222.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 21:45:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Generally not with such a small rev difference.  You could try the 
> latest driver, and firmware in the 7.7.  The driver source is on the Red 
> Hat drivers disk.  You should be able to drop in the .c, and .h in 
> drivers/scsi, and recompile.
> http://3ware.com/support/download.asp?code=5&id=7.7.0&softtype=Driver&releasenotes=&os=Windows
> 
> PS- Personally I'd suspect an XFS bug.  Try reiserfs.  I've been running 
> 2.4.23pres, and 2.4.23 on hundreds of 3ware of numerous different types. 
>   With no issue with the prior firmware release.

There are a lot of people, running RAID5 3ware's w/ Terrabyte arrays.  I
don't want to say it is not an XFS bug, but I find that highly suspect. 

js


-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.

