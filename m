Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157401AbQHACIM>; Mon, 31 Jul 2000 22:08:12 -0400
Received: by vger.rutgers.edu id <S160040AbQHABv1>; Mon, 31 Jul 2000 21:51:27 -0400
Received: from smtp.networkusa.net ([216.15.144.12]:9859 "EHLO smtp.networkusa.net") by vger.rutgers.edu with ESMTP id <S160144AbQHABvI>; Mon, 31 Jul 2000 21:51:08 -0400
Date: Mon, 31 Jul 2000 21:11:20 -0500
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <20000731211119.A28169@thune.mrc-home.org>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.rutgers.edu
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <8m4q9v$871$1@enterprise.cistron.net>; from miquels@cistron.nl on Mon, Jul 31, 2000 at 09:15:43PM +0000
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, Jul 31, 2000 at 09:15:43PM +0000, Miquel van Smoorenburg wrote:
> modules that use include/net ? The one in the kernel source is
> very, very different from the one in glibc .. so you have to compile
> with -I/path/to/kernel/include _anyway_

Maybe just make it mandatory that every time you upgrade the kernel, you
should rebuild the entire system.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
