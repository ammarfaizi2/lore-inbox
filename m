Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263412AbRFAI31>; Fri, 1 Jun 2001 04:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263413AbRFAI3S>; Fri, 1 Jun 2001 04:29:18 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:27760 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S263412AbRFAI3E>; Fri, 1 Jun 2001 04:29:04 -0400
Date: Fri, 1 Jun 2001 10:29:39 +0200 (SAST)
From: Marcin Kowalski <kowalski@datrix.co.za>
To: alan@lxorguk.ukuu.org.uk
cc: vichu@digitalme.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 VM
In-Reply-To: <E155bG5-0008AX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10106011028150.6653-100000@webman.medikredit.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I found this post of interest. I have 1.1 Gig of RAM but only 800mb of
Swap as I expect NOT to use that much memory... Could this be the cause of
the machines VERY erratic behaviour??? Kernel Panics, HUGE INOde and
Dcache.... ??

Regards
MarCin


-------------------------------------
#    Marcin Kowalski                # 
      On_Linux Developer.
       ->Datrix Solutions.<-
	
	Tel. 770-6146
#	Cel. 082-400-7603           #
-------------------------------------

On Thu, 31 May 2001 alan@lxorguk.ukuu.org.uk wrote:

> > My system has 128 Meg of Swap and RAM.
> 
> Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
> with 2.4.
> 
> Marcelo is working to change that but right now you are running something 
> explicitly explained as not going to work as you want
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

