Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130619AbRBQJDg>; Sat, 17 Feb 2001 04:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130679AbRBQJD0>; Sat, 17 Feb 2001 04:03:26 -0500
Received: from linuxcare.com.au ([203.29.91.49]:58119 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130619AbRBQJDT>; Sat, 17 Feb 2001 04:03:19 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 17 Feb 2001 20:01:21 +1100
To: Rick Richardson <rickr@mn.rr.com>
Cc: Anton Blanchard <anton@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Whats the rvmalloc() story?
Message-ID: <20010217200121.A3000@linuxcare.com>
In-Reply-To: <20010210220808.A18488@mn.rr.com> <20010217184633.A2484@linuxcare.com> <20010217024948.A1726@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010217024948.A1726@mn.rr.com>; from rickr@mn.rr.com on Sat, Feb 17, 2001 at 02:49:48AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> If you are offering to do this work now, here is a thread worth
> reading which includes a patch to start from...
> 
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0002.1/0586.html
> 
> BTW, Alan Cox sent me the following additional information in a
> private email.  Might as well get this in the mailing list archives
> for posterity so that the terms "rvmalloc" and "kiovecs" actually
> appear in the same post.  This way, at least, we all know what the
> plan for 2.6 should be.

Thanks for the info.

Since we arent going to put kiovecs in here for 2.4, I'll just add the 2.4
pci DMA fixes so my bttv card will work in my sparc and someone can look at
cleaning it up properly in 2.5.

Anton
