Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310504AbSCPRxn>; Sat, 16 Mar 2002 12:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310506AbSCPRxd>; Sat, 16 Mar 2002 12:53:33 -0500
Received: from pcls3.std.com ([199.172.62.105]:61874 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id <S310504AbSCPRxa>;
	Sat, 16 Mar 2002 12:53:30 -0500
Message-ID: <3C938693.6D29979C@world.std.com>
Date: Sat, 16 Mar 2002 12:53:23 -0500
From: Gordon J Lee <gordonl@world.std.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.18-m1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com> <3C92B1EA.F40BDBD5@world.std.com> <20020316055542.GA8125@kroah.com> <3C938093.D1640CB6@world.std.com> <20020316173434.GB10003@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4.18  shows two processors
> > 2.4.19-pre3 shows two processors
> > 2.4.19-pre3-ac1 shows four processors
>
> Great, thanks for testing.  I'd recommend using this hardware :)

>From your earlier post, I presume that the bug here was simply a presentation
layer bug in /proc/cpuinfo, and that kernel versions previous to 2.4.19-pre3-ac1
can actually use all of the logical processors.  Is this correct ?

If so, at which 2.4.x kernel did support for hyperthreading show up?

   - GL


