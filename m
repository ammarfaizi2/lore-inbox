Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130456AbQLHAvf>; Thu, 7 Dec 2000 19:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbQLHAv0>; Thu, 7 Dec 2000 19:51:26 -0500
Received: from mailgate.ics.forth.gr ([139.91.1.2]:29687 "EHLO
	ext1.ics.forth.gr") by vger.kernel.org with ESMTP
	id <S130456AbQLHAvM>; Thu, 7 Dec 2000 19:51:12 -0500
Posted-Date: Fri, 8 Dec 2000 02:18:27 +0200 (EET)
Organization: 
Date: Fri, 8 Dec 2000 02:18:26 +0200 (EET)
From: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
To: Karim Yaghmour <karym@opersys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <3A2FFEEC.3836165B@opersys.com>
Message-ID: <Pine.GSO.4.10.10012080218070.9184-100000@sappho.ics.forth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I'll check it out...

Thank you very much,

--) Vangelis


On Thu, 7 Dec 2000, Karim Yaghmour wrote:

> 
> You might want to try the Linux Trace Toolkit. It'll give you microsecond
> accuracy on program execution time measurement.
> 
> Check it out:
> http://www.opersys.com/LTT
> 
> Karim
> 
> Kotsovinos Vangelis wrote:
> > 
> > Is there any way to measure (with microsecond accuracy) the time of a
> > program execution (without using Machine Specific Registers) ?
> > I've already tried getrusage(), times() and clock() but they all have
> > 10 millisecond accuracy, even though they claim to have microsecond
> > acuracy.
> > The only thing that seems to work is to use one of the tools that measure
> > performanc through accessing the machine specific registers. They give you
> > the ability to measure the clock cycles used, but their accuracy is also
> > very low from what I have seen up to now.
> > 
> > Thank you very much in advance
> > 
> > --) Vangelis
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> -- 
> ===================================================
>                  Karim Yaghmour
>                karym@opersys.com
>           Operating System Consultant
>  (Linux kernel, real-time and distributed systems)
> ===================================================
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
