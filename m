Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266169AbRGDUCr>; Wed, 4 Jul 2001 16:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266165AbRGDUCh>; Wed, 4 Jul 2001 16:02:37 -0400
Received: from c009-h019.c009.snv.cp.net ([209.228.34.132]:14549 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S266166AbRGDUCZ>;
	Wed, 4 Jul 2001 16:02:25 -0400
X-Sent: 4 Jul 2001 20:02:19 GMT
Date: Wed, 4 Jul 2001 13:01:54 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <994279551.1116.0.camel@tux>
Message-ID: <Pine.LNX.4.33.0107041259490.252-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jul 2001, Ronald Bultje wrote:

> Hi,
>
> you might remember an e-mail from me (two weeks ago) with my problems
> where linux would not boot up or be highly instable on a machine with
> 256 MB RAM, while it was 100% stable with 128 MB RAM. Basically, I still
> have this problem, so I am running with 128 MB RAM again.

I suggest you look into the memory settings in your BIOS, and change them
to the most conservative available.  Or, throw out your memory and buy
some from a reputable manufacturer.  Your problem is definitely hardware.
There are racks full of linux machines with more than 128 MB RAM running
kernel 2.4 all over the world.  I personally installed a dozen.  It always
works fine.

-jwb

