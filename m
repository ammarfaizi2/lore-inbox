Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266482AbSKGKiX>; Thu, 7 Nov 2002 05:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266485AbSKGKiW>; Thu, 7 Nov 2002 05:38:22 -0500
Received: from mail.zmailer.org ([62.240.94.4]:54430 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266482AbSKGKiS>;
	Thu, 7 Nov 2002 05:38:18 -0500
Date: Thu, 7 Nov 2002 12:44:55 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ketil Froyn <kernel@ketil.froyn.name>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Majordomo results
Message-ID: <20021107104455.GR26330@mea-ext.zmailer.org>
References: <20021107101602Z266439-32597+17764@vger.kernel.org> <Pine.LNX.4.44.0211071125530.12653-100000@lexx.infeline.org> <20021107103545.B7579@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107103545.B7579@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 10:35:45AM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 11:26:19AM +0100, Ketil Froyn wrote:
> > On Thu, 7 Nov 2002, Majordomo@vger.kernel.org wrote:
> > > >>>> auth 27467a8e subscribe linux-kernel linux-kernel@vger.kernel.org
> > > Succeeded.
> > This could get interesting...
> 
> No it won't.  davem has put protection against such mail loops into
> this version of majordomo.  Its a real shame that people are so stupid
> that they try this.

  It just generates looped messages that are bounced to the list owner.
  Subscriber's message had these headers:  (yes, we do log EVERYTHING
  sent to Majordomo.. We don't log everything sent to the lists, though.
  There are a number of archives for that.)

>From ryan@completely.kicks-ass.org Thu Nov  7 05:16:02 2002
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:49803 "EHLO
        completely") by vger.kernel.org with ESMTP id <S266438AbSKGKQC>;
        Thu, 7 Nov 2002 05:16:02 -0500
Received: from ryan by completely with local (Exim 3.36 #1 (Debian))
        id 189jo9-0004J3-00
        for <Majordomo@vger.kernel.org>; Thu, 07 Nov 2002 02:22:41 -0800
From:   Foo Bar <linux-kernel@vger.kernel.org>
To:     Majordomo@vger.kernel.org
Date:   Thu, 7 Nov 2002 02:22:41 -0800
User-Agent: KMail/1.4.7-cool
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211070222.41246.linux-kernel@vger.kernel.org>
Sender: Ryan Cumming <ryan@completely.kicks-ass.org>
Return-Path: <ryan@completely.kicks-ass.org>


> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html

/Matti Aarnio   --  co-postmaster of vger.kernel.org
