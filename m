Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315490AbSECAiQ>; Thu, 2 May 2002 20:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSECAiP>; Thu, 2 May 2002 20:38:15 -0400
Received: from [194.234.65.222] ([194.234.65.222]:6307 "EHLO mustard.heime.net")
	by vger.kernel.org with ESMTP id <S315490AbSECAiO>;
	Thu, 2 May 2002 20:38:14 -0400
Date: Fri, 3 May 2002 02:37:55 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE hotplug support?
In-Reply-To: <E173RID-0005Ii-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205030237260.31927-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Alan Cox wrote:

> > > The request aliasing effects will be almost for sure disasterous
> > > to overall system performance.
> > 
> > hm. all I want is lots of space. I don't need speed here. What is 
> > 'disasterous' here?
> 
> Halve the expected throughput and subtract a bit. Since you can put 8
> ports on a 3ware card one drive per port at 160Gb a drive I suspect you
> don't need master/slave pairs 8)
>
I do. I can't afford 3ware
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

