Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbTCZWeK>; Wed, 26 Mar 2003 17:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbTCZWeK>; Wed, 26 Mar 2003 17:34:10 -0500
Received: from [12.47.58.223] ([12.47.58.223]:12345 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262603AbTCZWeJ>; Wed, 26 Mar 2003 17:34:09 -0500
Date: Wed, 26 Mar 2003 16:49:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Andries.Brouwer@cwi.nl, corryk@us.ibm.com, linux-kernel@vger.kernel.org,
       lvm-devel@sistina.com
Subject: Re: struct dm_ioctl
Message-Id: <20030326164938.6558a2c5.akpm@digeo.com>
In-Reply-To: <35A0ECE4-5F89-11D7-BBDF-000393CA5730@fib011235813.fsnet.co.uk>
References: <UTC200303261127.h2QBRTt05048.aeb@smtp.cwi.nl>
	<35A0ECE4-5F89-11D7-BBDF-000393CA5730@fib011235813.fsnet.co.uk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2003 22:45:15.0511 (UTC) FILETIME=[5E514870:01C2F3E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <joe@fib011235813.fsnet.co.uk> wrote:
>
> 
> On Wednesday, March 26, 2003, at 11:27 AM, Andries.Brouwer@cwi.nl wrote:
> 
> > One is struct dm_ioctl. Google tells me that it was
> > noticed already that it defined a broken interface,
> > and Kevin Corry submitted a patch against 2.5.51.
> > Today this has not been applied yet.
> >
> > What is the status? Should I resubmit that patch?
> 
> The patch is queued, and should be merged very soon.  The only reason I 
> delayed was that I wanted to update both the 2.4 and 2.5 releases at 
> the same time so that people can continue to switch back and forth 
> between kernels.  That said, I have left it too long, sorry.

Please send me a copy.  I'd like to get all the required bits and pieces for
this conversion queued up in one place so we can actually look at it,
evaluate its impact and test it.  The current process of creeping revelations
is quite confusing.

Also if userspace tools need upgrading please send me the URLs so I can make
people well aware of the upgrade requirements and process.

Thanks.

