Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRFGQss>; Thu, 7 Jun 2001 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbRFGQsi>; Thu, 7 Jun 2001 12:48:38 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:40191 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S261969AbRFGQsd>;
	Thu, 7 Jun 2001 12:48:33 -0400
Message-ID: <3B1FB07D.C6C03EF0@fc.hp.com>
Date: Thu, 07 Jun 2001 10:49:01 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: markh@compro.net
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pset patch??
In-Reply-To: <3B1F7130.94357A3C@compro.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try
<http://resourcemanagement.unixsolutions.hp.com/WaRM/schedpolicy.html>.
It may do what you want.

--
Khalid

Mark Hounschell wrote:
> 
>  Sorry if this is off topic. I've searched the archives and found
> references to
> what I'm looking for but the URL's take me nowhere. The references I'm
> referring to
> are for pset patches that will enable me to lock down a processor in an
> smp env.
> Lock down meaning I need to be able to lock out all system interrupts
> and tasks from
> a defined cpu and lock in a particular task/tasks and set of external
> interrupts to
> that same cpu. Yes it's for a real time app but not sure if rtlinux is
> what I am
> in need of.
> 
> I see references to this site http://isunix.it.ilstu.edu/~thockin/pset/.
> >From reading the archives it looks like what I'm looking for but there
> is nothing there.
> 
> Is what I need to do possible and if I need this patch do to it could
> someone tell
> me where I might find it? Sorry if this is OT but I'm at a dead end road
> and didn't
> know where else to ask??  Thanks in advance.
> 
> Mark Hounschell
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
