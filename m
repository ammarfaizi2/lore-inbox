Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbSJCQvA>; Thu, 3 Oct 2002 12:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSJCQvA>; Thu, 3 Oct 2002 12:51:00 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:31986 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261429AbSJCQu7>; Thu, 3 Oct 2002 12:50:59 -0400
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
	logging macros, SCSI RAIDdevice)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@digeo.com
In-Reply-To: <20021003165142.GA25316@suse.de>
References: <200210031551.g93FpwsR000330@darkstar.example.net>
	<Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com> 
	<20021003165142.GA25316@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 18:04:14 +0100
Message-Id: <1033664654.28850.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We still need some work for low memory boxes (where low isn't
> necessarily all that low). On my 128MB laptop I can lock up the box
> for a minute or two at a time by doing two things at the same time,
> like a bk pull, and switching desktops.
> 
> I dread to think how a 16 or 32MB box performs these days..

On 2.4.1x with rmap, better than 2.2. A 32Mb box with rmap vm on 2.4,
running the xfce/rox desktop and sylpheed is very snappy indeed

