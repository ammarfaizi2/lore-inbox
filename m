Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbSLKQSd>; Wed, 11 Dec 2002 11:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSLKQSc>; Wed, 11 Dec 2002 11:18:32 -0500
Received: from [81.2.122.30] ([81.2.122.30]:45573 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267210AbSLKQSa>;
	Wed, 11 Dec 2002 11:18:30 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212111633.gBBGXlki008160@darkstar.example.net>
Subject: Re: Reliable hardware
To: orion@cora.nwra.com (Orion Poplawski)
Date: Wed, 11 Dec 2002 16:33:47 +0000 (GMT)
Cc: scott@thomasons.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <3DF76302.7040503@cora.nwra.com> from "Orion Poplawski" at Dec 11, 2002 09:08:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>Random lockups on dual athlons are a notorious problem under all
> >>OS's. Start by checking it passes memtest86, that will verify the
> >>RAM is ok - and the AMD is -very- picky about RAM.
> >>
> >>If thats ok then let me know which board you have, what is plugged
> >>into it and what PSU you are using.
> >>    
> >>
> >
> >I have two AMD MP 2000+ cpus in an ASUS A7M266-D. Even after returning 
> >my memory for new chips the store owner memtest86'd, my combo of cpus 
> >and mobo was finding the occasional error. I finally ended up 
> >resolving it by simply underclocking the bus about 6Mhz :( 
> >
> >Next time, I'm buying ECC memory.

Why?  ECC memory guards against a single bit error in the RAM, nothing
else, (except that it also reports double bit errors).

John.
