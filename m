Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRIYBBh>; Mon, 24 Sep 2001 21:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274306AbRIYBB1>; Mon, 24 Sep 2001 21:01:27 -0400
Received: from pblx.net ([64.167.128.182]:16901 "HELO dobie.pblx.net")
	by vger.kernel.org with SMTP id <S274299AbRIYBBN>;
	Mon, 24 Sep 2001 21:01:13 -0400
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010925005745.A2702@elfie.cavy.de>
Date: Mon, 24 Sep 2001 18:01:32 -0700 (PDT)
From: shewp <shewp@pblx.net>
To: Heinz Diehl <hd@cavy.de>
Subject: Re: broken /proc/partitions
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010925010122Z274299-760+16462@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works perfectly for me on 2.4.9.

I have 7 u2w drives (and a dat)
on an ahc-2940u2w.

in pre14 I thought I saw some pretty hefty
changes in this area, but i don't know the
kernel well enough to say. 

scsi or ide? any other verification?


On 24-Sep-2001 Heinz Diehl wrote:
> On Mon Sep 24 2001, shewp wrote:
> 
>> did anyone notice that cat /proc/partitions on 2.4.10 loops 
>> infinitely?
>> it makes dump loop too, which is how i found out.
> 
> Here it works perfectly, no loops, no dump loops.
> 
> -- 
># Heinz Diehl, 68259 Mannheim, Germany
># Techno-Vinyl for sale, get the list from "http://www.cavy.de/vinyl.txt"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

