Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262426AbTCMQIn>; Thu, 13 Mar 2003 11:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262427AbTCMQIn>; Thu, 13 Mar 2003 11:08:43 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:49170 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262426AbTCMQIm>; Thu, 13 Mar 2003 11:08:42 -0500
Date: Thu, 13 Mar 2003 16:19:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mb800 watchdog driver
Message-ID: <20030313161927.A30172@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1047543064.16975.23.camel@gregs> <20030313161033.GA8751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030313161033.GA8751@suse.de>; from davej@codemonkey.org.uk on Thu, Mar 13, 2003 at 03:10:33PM -0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 03:10:33PM -0100, Dave Jones wrote:
> On Thu, Mar 13, 2003 at 08:11:04AM +0000, Grzegorz Jaskiewicz wrote:
>  > 
>  > I've wrote small driver for mb800 motherboards (x86, intel). And i want
>  > to share with others. 
>  > Any comments/patches are welcome.
> 
> 
> > #include <sys/syscall.h>
> 
> not needed.

Nor does it even compile with any recent kernel..

