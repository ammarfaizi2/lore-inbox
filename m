Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279904AbRKRReO>; Sun, 18 Nov 2001 12:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279927AbRKRReE>; Sun, 18 Nov 2001 12:34:04 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:18181 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S279904AbRKRRdz>;
	Sun, 18 Nov 2001 12:33:55 -0500
From: "Tony Hoyle" <tmh@nothing-on.tv>
Subject: Re: [PATCH] devfs v196 available
Date: Sun, 18 Nov 2001 17:33:47 +0000
Organization: cvsnt.org news server
Message-ID: <pan.2001.11.18.17.33.47.49.903@nothing-on.tv>
In-Reply-To: <Pine.LNX.4.33.0111162035180.29140-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: sisko.my.home 1006104826 6138 192.168.100.2 (18 Nov 2001 17:33:46 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Pan/0.10.0.93 (Unix)
X-Comment-To: "Roman Zippel" <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001 22:59:05 +0000, Roman Zippel wrote:

> Hi,
> 
> On Sat, 3 Nov 2001, Richard Gooch wrote:
> 
>>   Hi, all. Version 196 of my devfs patch is now available from:
> 
I noticed with the 2.4.15pre kernels it doesn't support my LS-120 floppy
- there are no devfs calls in ide-floppy.c.  How hard would it be to add
these, or is it a 2.5 issue?

Tony
