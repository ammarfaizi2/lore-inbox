Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUITLAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUITLAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUITK7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:59:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:8334 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266195AbUITK7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:59:13 -0400
Date: Mon, 20 Sep 2004 12:56:18 +0200
From: Olaf Hering <olh@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920105618.GB24928@suse.de>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <Pine.LNX.4.61.0409201220200.3460@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0409201220200.3460@scrub.home>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 20, Roman Zippel wrote:

> Hi,
> 
> On Mon, 20 Sep 2004, Olaf Hering wrote:
> 
> >  On Mon, Sep 20, Andries.Brouwer@cwi.nl wrote:
> > 
> > > then /etc/mtab can die. Comments? Better solutions?
> > 
> > Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
> > introduced. So, kill it today from your mount binary! TODAY. ...
> 
> How do you distinguish between manual and automatic loop device setup?

-v

> How do you filter /proc/mounts for chroot environments?

you have a chroot enviroment without /proc mounted?
Then just create /proc/mounts?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
