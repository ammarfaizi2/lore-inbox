Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292409AbSCDPKV>; Mon, 4 Mar 2002 10:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292410AbSCDPKC>; Mon, 4 Mar 2002 10:10:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292409AbSCDPJu>;
	Mon, 4 Mar 2002 10:09:50 -0500
Message-ID: <3C838E52.CE3020B5@mandrakesoft.com>
Date: Mon, 04 Mar 2002 10:10:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <20020304145450.GA14256@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 2.5.6-pre2-akpm compiled with MPIO_DEBUG = 0 and ext2
> filesystem mounted with delalloc.
> 
> tiobench and dbench were on ext2.
> bonnie++ and most other tests were on reiserfs.
> 
> 2.5.6-pre2-akpm throughput on ext2 is much improved.
> 
> http://home.earthlink.net/~rwhron/kernel/akpm.html

This page of statistics is pretty gnifty -- I wish more people posted
such :)

I also like your other comparisons at the top of that link...  I was
thinking, what would be even more neat and more useful as well would be
to post comparisons -between- the various kernels you have tested, i.e.
a single page that includes benchmarks for 2.4.x-official,
2.5.x-official, -aa, -rmap, etc.

Regards,

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
