Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313428AbSDGW1T>; Sun, 7 Apr 2002 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313480AbSDGW1S>; Sun, 7 Apr 2002 18:27:18 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16010 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313428AbSDGW1R>;
	Sun, 7 Apr 2002 18:27:17 -0400
Date: Sun, 7 Apr 2002 16:22:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, brian@worldcontrol.com,
        linux-kernel@vger.kernel.org
Subject: Re: more on 2.4.19pre... & swsusp
Message-ID: <20020407162244.F46@toy.ucw.cz>
In-Reply-To: <E16tz9Q-0002sH-00@the-village.bc.nu> <1018143212.8480.99.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > On a different note.  Why doesn't the ac branch have ftpfs yet?  Besides
> > > the fact that it sometimes has problems with ls'ing a directory because
> > 
> > Because its perfectly doable in user space. Its for testing useful stuff not
> > a dumping ground
> 
> Wouldn't that be true of any networked filesystem?  They should all be
> able to be done in userspace.  The problem with that would be it loses
> it's transparency to the user and increases latency.  Sure ftpfs can be

uservfs.sf.net.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

