Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132340AbRADKHe>; Thu, 4 Jan 2001 05:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132411AbRADKHX>; Thu, 4 Jan 2001 05:07:23 -0500
Received: from [204.143.97.92] ([204.143.97.92]:64270 "EHLO arisen.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S132340AbRADKHM>;
	Thu, 4 Jan 2001 05:07:12 -0500
Date: Thu, 4 Jan 2001 16:09:52 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: brian@worldcontrol.com
cc: linux-kernel@vger.kernel.org
Subject: Re: soffice, 2.2.18, cpu 97% idle, loadavg 6.05
In-Reply-To: <20010104003147.A10345@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.04.10101041609280.30212-100000@hantana.pdn.ac.lk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you reproduce the same error on GCC 2.72?

Anuradha

On Thu, 4 Jan 2001 brian@worldcontrol.com wrote:

> On Thu, Jan 04, 2001 at 01:54:17PM +0600, Anuradha Ratnaweera wrote:
> > 
> > What is the compiler?
> 
> % gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
> gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> 
> Linux distribution is Redhat 6.2, with all updates.
> 
> -- 
> Brian Litzinger <brian@worldcontrol.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
