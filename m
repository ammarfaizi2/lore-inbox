Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315493AbSECA0B>; Thu, 2 May 2002 20:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSECA0A>; Thu, 2 May 2002 20:26:00 -0400
Received: from [194.234.65.222] ([194.234.65.222]:45724 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S315493AbSECA0A>; Thu, 2 May 2002 20:26:00 -0400
Date: Fri, 3 May 2002 02:25:41 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE hotplug support?
In-Reply-To: <3CD18318.7060407@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205030223520.31927-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 15 drives == 16 interfaces == 8 channels == 4 controllers
> with primary and secondary channel.
> 
> He will have groups of about 4 drives on each channel wich
> serialize each other due to excessive IRQ line sharing and
> master slave issues.
> 
> 8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
> a classical RAID controller card for this kind of
> setup.
> 
> The request aliasing effects will be almost for sure disasterous
> to overall system performance.

hm. all I want is lots of space. I don't need speed here. What is 
'disasterous' here?
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

