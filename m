Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSCKMPx>; Mon, 11 Mar 2002 07:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293712AbSCKMPn>; Mon, 11 Mar 2002 07:15:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2820 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293711AbSCKMP0>; Mon, 11 Mar 2002 07:15:26 -0500
Date: Mon, 11 Mar 2002 13:15:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, dalecki@evision-ventures.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend support for IDE
Message-ID: <20020311121504.GB5383@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020309210319.GA691@elf.ucw.cz> <E16joxm-0002g6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16joxm-0002g6-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > then flush the disk cache, then when it completes you can tell the
> > > drive
> > 
> > Disks that need cache flush are broken, anyway -- they lied us on
> > command completion -- right?
> 
> Wrong. Please read the spec. If you are going to be the IDE
> maintainer you are

I'm *NOT* going to be the IDE maintainer. Here's pavel!
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
