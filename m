Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278447AbRKDEPh>; Sat, 3 Nov 2001 23:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278476AbRKDEP1>; Sat, 3 Nov 2001 23:15:27 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51724 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278447AbRKDEPL>; Sat, 3 Nov 2001 23:15:11 -0500
Message-ID: <3BE4BFA0.4DBF213F@zip.com.au>
Date: Sat, 03 Nov 2001 20:10:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c556 basicly not working.
In-Reply-To: <Pine.LNX.4.33.0111032221320.10049-100000@clubneon.clubneon.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> 
> I think I posted a message earily to l-k, but I was really distraced at
> the time, and haven't seen it show up yet, so I probally got something
> wrong.
> 
> Anyway, for a little more information:  I have a 3Com mini-PCI card in my
> laptop.  It is based on the 3c556 chip.  I'm using the 3c59x driver from
> 2.4.13-ac5.
> 
> Both compiled into the kernel or as a module I'm having no luck.  The
> driver seems to load without complaints.  But reports the MAC address as
> all Fs.  Actually most information I've seen returned from the card is all
> Fs.
> 

I've never seen a satisfactory explanation for this one.  Usually
it's fixed by altering the `PnP OS' setting in the BIOS.
