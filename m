Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSE0Ueu>; Mon, 27 May 2002 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316758AbSE0Uet>; Mon, 27 May 2002 16:34:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39665 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316757AbSE0Uer>; Mon, 27 May 2002 16:34:47 -0400
Subject: Re: Siemens powermanagment patent? [was Re: patent on
	O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@e-mind.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020527173611.GA762@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 22:36:46 +0100
Message-Id: <1022535406.11859.323.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 18:36, Pavel Machek wrote:
> Hi!
> 
> > > What, so there are _no_ patents or other restrictions on any of then
> > > commercial embedded OS vendor products?  I would imagine that you need
> > > to pay some sort of license fee to those vendors in order to use their
> > > code for products you sell.
> > 
> > Thousands of them. Some of them like the Siemens power management patent
> > really hurt Linux too.
> 
> Can you elaborate on this one?

Siemens own a patent on what basically amounts to keeping per task power
management settings.(US 6,298,448)
> 
> > I'd suggest Andrea does something else. Ask the Red Hat people for a formal
> > confirmation he can use it, just like IBM with RCU. I have this funny feeling
> > that he'll get an extremely positive response.
> 
> Does he need to ask permission? Code is GPL-ed, "no additional
> restrictions" in GPL should shield him...

I think the GPL is sufficient, but if he wishes to be cautious and ask
for a formal confirmation Red Hat will be happy to oblige. 

Alan

