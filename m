Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268859AbRHBJ1q>; Thu, 2 Aug 2001 05:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRHBJ1g>; Thu, 2 Aug 2001 05:27:36 -0400
Received: from rj.sgi.com ([204.94.215.100]:19594 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268859AbRHBJ11>;
	Thu, 2 Aug 2001 05:27:27 -0400
Date: Thu, 2 Aug 2001 02:25:48 -0700 (PDT)
From: jeremy@classic.engr.sgi.com (Jeremy Higdon)
Message-Id: <10108020225.ZM236505@classic.engr.sgi.com>
In-Reply-To: Andrea Arcangeli <andrea@suse.de>
        "Re: changes to kiobuf support in 2.4.(?)4" (Aug  2, 11:11am)
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> 
	<20010802084259.H29065@athlon.random>  <andrea@suse.de> 
	<10108020031.ZM229058@classic.engr.sgi.com> 
	<20010802094517.I29065@athlon.random> 
	<10108020110.ZM232959@classic.engr.sgi.com> 
	<20010802102431.L29065@athlon.random> 
	<10108020142.ZM233422@classic.engr.sgi.com> 
	<20010802111150.N29065@athlon.random>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: changes to kiobuf support in 2.4.(?)4
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 2, 11:11am, Andrea Arcangeli wrote:
> 
> > At 13000 IOPS, when allocating and freeing on every I/O request,
> > the allocate/free overhead was approximately .6% on a 2 CPU system,
> > where the total overhead was about 25%.  So I would theoretically
> > gain 3% (maybe a little better since there is locking involved) if
> > I could avoid the alloc/free.
> 
> Ok good.
> 
> Andrea


So one more question for now:

Where do I get the O_DIRECT patch?

Oh, and is there a plan to get it into 2.4.X?

(ok, so two questions)

thanks

jeremy
