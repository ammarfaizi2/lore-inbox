Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265124AbRFUTIa>; Thu, 21 Jun 2001 15:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265125AbRFUTIU>; Thu, 21 Jun 2001 15:08:20 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:30986 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265124AbRFUTIJ>; Thu, 21 Jun 2001 15:08:09 -0400
Date: Thu, 21 Jun 2001 14:08:02 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200106211904.PAA10433@mah21awu.cas.org>
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com> from "Timur Tabi" at Jun 21, 2001 01:46:48 PM
Subject: Re: Controversy over dynamic linking -- how to end the panic
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <sxMyWB.A.NBB.TYkM7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Mike Harrold <mharrold@cas.org> on Thu, 21 Jun 2001
15:04:21 -0400 (EDT)


> Not to mention utterly unenforceable. Consider:
> 
> 1) Oracle Corp. builds their database for Linux on a Linux system.
> 2) Said system comes with standard header files, which happen in this case to
>    be GPL'd header files.
> 3) Oracle Corp.'s database becomes GPL.
> 
> There's not a court in the civilised world that would uphold the GPL in that
> scenario.

I do believe, however, that in these cases the header files in question are
under the LGPL, which does specifically allow linking and #including in non-GPL
and non-LGPL code.

In my opinion, this whole thing would just go away (including some of
Microsoft's anti-GPL rants), if the FSF officially declared that under the GPL,
#including a GPL header file does NOT force your code to be also GPL.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

