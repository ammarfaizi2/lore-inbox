Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSHAMFQ>; Thu, 1 Aug 2002 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSHAMEc>; Thu, 1 Aug 2002 08:04:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8832 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318721AbSHAMEa>;
	Thu, 1 Aug 2002 08:04:30 -0400
Date: Thu, 1 Aug 2002 12:49:03 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Brad Hards <bhards@bigpond.net.au>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Message-ID: <20020801104903.GC159@elf.ucw.cz>
References: <Pine.GSO.4.21.0207301755200.6010-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0207301805030.6010-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207301805030.6010-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > ICBW, but wasn't uint<n>_t only promised to be at least <n> bits?
> 
> As the matter of fact, IHBW.

pavel@Elf:~$ wtf ICBW
Gee...  I don't know what ICBW means...
pavel@Elf:~$ wtf IHBW
Gee...  I don't know what IHBW means...
pavel@Elf:~$
 
Would you care to submit patch for wtf(6)? ;-)
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
