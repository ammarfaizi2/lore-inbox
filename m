Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285143AbRLWILZ>; Sun, 23 Dec 2001 03:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285585AbRLWILP>; Sun, 23 Dec 2001 03:11:15 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:8164 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S285143AbRLWIK5>; Sun, 23 Dec 2001 03:10:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Jim Radford <radford@blackbean.org>, Adam Keys <akeys@post.cis.smu.edu>
Subject: Re: IDE Harddrive Performance
Date: Sun, 23 Dec 2001 02:11:45 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011222182043.GA4474@blackbean.org>
In-Reply-To: <20011222182043.GA4474@blackbean.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011223081052.ZSNU6450.rwcrmhc52.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 22, 2001 12:20, Jim Radford wrote:
> > hda: Maxtor 93073U6, ATA DISK drive
> > hdc: Maxtor 90840D6, ATA DISK drive
> >
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in 86.98 seconds =753.46 kB/sec
> > /dev/hdc:
> >  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
>
> I'm in the same boat with my Maxtor 54098U8.  It has been getting
> progressively slower.  Two weeks ago I was getting a whopping 3MB/s,
> now I get:
>
> /dev/hda:
>  Timing buffered disk reads:  64 MB in 115.29 seconds =568.44 kB/sec

I just ripped my machine apart, cleaned it out and made sure all the 
connections are snug.  I didn't find anything glaringly wrong inside, so my 
current conclusion is that my machine just gets too durn hot for the drive to 
function properly.  I'm going to periodically test my throughput to see if it 
degrades over time.  See if taking your machine down for a few hours helps 
things out.  If so we can yell at Maxtor, otherwise its back on the bug hunt.

Thanks to everyone who sent suggestions!  Hopefully I'm through with this 
hiccup. :)
-- 
akk~
