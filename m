Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160028AbQHAJUF>; Tue, 1 Aug 2000 05:20:05 -0400
Received: by vger.rutgers.edu id <S157638AbQHAJTs>; Tue, 1 Aug 2000 05:19:48 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:3101 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S157621AbQHAJSA>; Tue, 1 Aug 2000 05:18:00 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 1 Aug 2000 09:38:33 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m65qp$mpe$1@enterprise.cistron.net>
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net> <20000731211119.A28169@thune.mrc-home.org>
X-Trace: enterprise.cistron.net 965122713 23342 195.64.65.200 (1 Aug 2000 09:38:33 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >20000731211119.A28169@thune.mrc-home.org>,
Mike Castle  <dalgoda@ix.netcom.com> wrote:
>On Mon, Jul 31, 2000 at 09:15:43PM +0000, Miquel van Smoorenburg wrote:
>> modules that use include/net ? The one in the kernel source is
>> very, very different from the one in glibc .. so you have to compile
>> with -I/path/to/kernel/include _anyway_
>
>Maybe just make it mandatory that every time you upgrade the kernel, you
>should rebuild the entire system.

Well for modules, yes, that is pretty much the case isn't it ?

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
