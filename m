Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278424AbRJSPPi>; Fri, 19 Oct 2001 11:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278426AbRJSPP2>; Fri, 19 Oct 2001 11:15:28 -0400
Received: from [195.246.135.25] ([195.246.135.25]:1542 "EHLO
	chert.194.133.98.200") by vger.kernel.org with ESMTP
	id <S278424AbRJSPPK>; Fri, 19 Oct 2001 11:15:10 -0400
Date: Fri, 19 Oct 2001 19:14:46 +0200
From: Andrei Lahun <Uman@editec-lotteries.com>
To: safemode <safemode@speakeasy.net>
Cc: Uman@editec-lotteries.com, linux-kernel@vger.kernel.org
Subject: Re: problems with I/O performance with 2.4.12-ac3
Message-Id: <20011019191446.7748bd80.uman@chert>
In-Reply-To: <20011019163058.1bb7c6f7.uman@chert>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001 09:27:35 -0400
safemode <safemode@speakeasy.net> wrote:

>
> You should give ide and drive chipset info.  This is not a problem seen by 
> everyone using the ac3 kernel.  Mine for instance run just fine.  What 
> settings did you use with bonnie++?  all of this is required info if someone 
> wanted to look and see why you are getting those numbers.
> 
My chipset is VIA apollo 133-A ( old shirt).
I have run bonnie++ just like bonnie -s 256 , and i have 128 MB of memory,
disk is MAXTOR 52049H4.With old kernels i always had results something like i have with 2.4.13-pre now .
And i have read one post in lkml about 2 times less write output with 2.4.13 -pre comparing with ac,
mine result are opposite.
