Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTAZTvG>; Sun, 26 Jan 2003 14:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTAZTvG>; Sun, 26 Jan 2003 14:51:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36878 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266969AbTAZTvG>; Sun, 26 Jan 2003 14:51:06 -0500
Date: Sun, 26 Jan 2003 21:00:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Kevin Lawton <kevinlawton2001@yahoo.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030126200021.GB25524@atrey.karlin.mff.cuni.cz>
References: <20030124154935.GB20371@elf.ucw.cz> <20030124171415.34636.qmail@web80310.mail.yahoo.com> <20030124180255.GF1099@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124180255.GF1099@marowsky-bree.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > To get any level of security with UML, you need to use "jailed mode"
> > in which performance takes a big beating.  To fix this, you need
> > patches to Linux as a host, to make it offer a better environment
> > for running UML guests.  From a commercial perspective, then you have
> > a patched Linux host + totally different port of a Linux guest.
> 
> That commercial perspective is then completely misguided.
> 
> All alternatives I have seen to UML (plex, vmware, UMLinux) suck
 > IMHO. They

I know UML, but what is UMLinux?
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
