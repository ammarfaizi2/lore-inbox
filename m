Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTBHSSn>; Sat, 8 Feb 2003 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBHSSn>; Sat, 8 Feb 2003 13:18:43 -0500
Received: from bitmover.com ([192.132.92.2]:35512 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267048AbTBHSSm>;
	Sat, 8 Feb 2003 13:18:42 -0500
Date: Sat, 8 Feb 2003 10:28:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030208182820.GA14035@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@suse.cz>, Andrea Arcangeli <andrea@suse.de>,
	lm@bitmover.com, linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <20030207145651.GA345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207145651.GA345@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Note, I'm using my own GPL software to checkout from the bitkeeper
> > servers (I don't want to miss the additional information stored in
> 
> Are you going to put up copy of that sw somewhere? I guess more people
> are interested...

Two things:

1) We're going to make a CVS archive of Linus tree available, automatically
   updated, and we'll rsync it to some public place like kernel.org so you
   can get at the data in a way you want with no BK involved at all.
2) If you beat on our servers with that stupid script, we'll shut down the
   http access.  Give us a break already.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
