Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262293AbSJIS16>; Wed, 9 Oct 2002 14:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSJIS15>; Wed, 9 Oct 2002 14:27:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:27790 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262293AbSJISZ6>;
	Wed, 9 Oct 2002 14:25:58 -0400
Message-ID: <3DA47606.546A558E@digeo.com>
Date: Wed, 09 Oct 2002 11:31:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: [PATCH] 2.5 version of device mapper submission
References: <20021009181259.GA25050@fib011235813.fsnet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 18:31:34.0822 (UTC) FILETIME=[18AE7460:01C26FC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:
> 
> The 2.5 port of device-mapper is available from:
> 
>    bk://device-mapper.bkbits.net/2.5-stable

Is it available in a form which everyone can access?

> There are 6 changesets in here that are summarised at the end of this
> email.
> 
> If you wish to use it you will need to install libdevmapper:
> 
>    ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-latest.tgz
> 

That appears to have 2.4.19 diffs only?

What I really wanted to know is "are you still using kiobufs"?

If so, what do we need to do to not do that?
