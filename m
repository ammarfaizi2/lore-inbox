Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293489AbSB1WDo>; Thu, 28 Feb 2002 17:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310148AbSB1WCO>; Thu, 28 Feb 2002 17:02:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56850 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310142AbSB1V72>; Thu, 28 Feb 2002 16:59:28 -0500
Date: Thu, 28 Feb 2002 16:58:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rick Stevens <rstevens@vitalstream.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Big file support
In-Reply-To: <3C7D3587.8080609@vitalstream.com>
Message-ID: <Pine.LNX.3.96.1020228165550.2006C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Rick Stevens wrote:

> I'm not certain if this is the right place, but are there plans to
> have big file support (files >2GB) anytime soon?  I ask, as we use
> Linux to serve LOTS of streaming media and the logs for popular sites
> often exceed 2GB.  I'd like to see the ability to handle at least 16GB
> files, possibly more.
> 
> Please cc: me on any replies if possible.  I've been REALLY busy and
> am finding it hard to keep up with l-k traffic.

You must be really behind, large file support has been in the current
kernel for ~14 months. Of course if your application isn't compiled with
LFS enabled it doesn't matter, or if it keeps offsets in long instead of
offset types...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

