Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTAWNxI>; Thu, 23 Jan 2003 08:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTAWNxI>; Thu, 23 Jan 2003 08:53:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49928 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265262AbTAWNxH>; Thu, 23 Jan 2003 08:53:07 -0500
Date: Thu, 23 Jan 2003 15:02:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Message-ID: <20030123140215.GA1229@atrey.karlin.mff.cuni.cz>
References: <20030119233750.GA674@elf.ucw.cz> <20030123063701.1F7172C2E0@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123063701.1F7172C2E0@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Everyone loves reimplementing strdup.  Give them a kstrdup (basically
> > > from drivers/md).
> > 
> > I believe it would be better to call it strdup.
> 
> No.  Don't confuse people.

Ehm?! What's confusing on strdup? Or you want to also introduce
kmemcpy, kmemcmp, ksprintf etc?
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
