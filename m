Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289960AbSAKNx2>; Fri, 11 Jan 2002 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289959AbSAKNxO>; Fri, 11 Jan 2002 08:53:14 -0500
Received: from web14911.mail.yahoo.com ([216.136.225.249]:23558 "HELO
	web14911.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289957AbSAKNxB>; Fri, 11 Jan 2002 08:53:01 -0500
Message-ID: <20020111135300.67270.qmail@web14911.mail.yahoo.com>
Date: Fri, 11 Jan 2002 08:53:00 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: About block device request function
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10 2002, Jens Axboe wrote:
> 
> Read drivers/block/ll_rw_blk.c:blk_get_queue() -- >
> either a driver uses
> the statically allocated per-major queue, or it > >
> provides its own and
> defines a get_queue function to return it.
> 
> You are still heading in the wrong direction :/

You mean that I am still in the wrong direction? I
need to use the loop device to implement my project?
Can you give me the right directions? Thank you very
much.

Regards,

Michael



______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
