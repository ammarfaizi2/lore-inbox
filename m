Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbTCZMgO>; Wed, 26 Mar 2003 07:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbTCZMgO>; Wed, 26 Mar 2003 07:36:14 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:22279 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261652AbTCZMgN>; Wed, 26 Mar 2003 07:36:13 -0500
Date: Wed, 26 Mar 2003 12:48:14 +0000
Subject: Re: struct dm_ioctl
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: corryk@us.ibm.com, linux-kernel@vger.kernel.org, lvm-devel@sistina.com
To: Andries.Brouwer@cwi.nl
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
In-Reply-To: <UTC200303261127.h2QBRTt05048.aeb@smtp.cwi.nl>
Message-Id: <35A0ECE4-5F89-11D7-BBDF-000393CA5730@fib011235813.fsnet.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, March 26, 2003, at 11:27 AM, Andries.Brouwer@cwi.nl wrote:

> One is struct dm_ioctl. Google tells me that it was
> noticed already that it defined a broken interface,
> and Kevin Corry submitted a patch against 2.5.51.
> Today this has not been applied yet.
>
> What is the status? Should I resubmit that patch?

The patch is queued, and should be merged very soon.  The only reason I 
delayed was that I wanted to update both the 2.4 and 2.5 releases at 
the same time so that people can continue to switch back and forth 
between kernels.  That said, I have left it too long, sorry.

- Joe

