Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281048AbRKLWZD>; Mon, 12 Nov 2001 17:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281084AbRKLWYy>; Mon, 12 Nov 2001 17:24:54 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:46210 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S281048AbRKLWYk>;
	Mon, 12 Nov 2001 17:24:40 -0500
Date: Mon, 12 Nov 2001 23:15:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Thomas Foerster <puckwork@madz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Module / Patch with implements "sshfs"
Message-ID: <20011112231545.A1081@elf.ucw.cz>
In-Reply-To: <20011112080214Z281309-17408+13481@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112080214Z281309-17408+13481@vger.kernel.org>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > A simpler way is to use the kio_fish
> > And since it is KDE all KDE programs will be able to use it :-)
> > (To be sure I tried to create a file with advanced editor and save it
> >  remote - it worked! :-)
> 
> Seems nice, but the problem is :
> 
> I'm not using X :)
> 
> What i want to do is :
> 
> Mount our external Webserver from our internal Administration Server via 100MBit LAN
> connection.

Install uservfs(.sf.net), then cd /overlay/#sh:user@host/.
								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


