Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270005AbRHNCZK>; Mon, 13 Aug 2001 22:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270003AbRHNCY6>; Mon, 13 Aug 2001 22:24:58 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:24202 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S269948AbRHNCYq>;
	Mon, 13 Aug 2001 22:24:46 -0400
Message-ID: <3B788DAE.4E2A839D@randomlogic.com>
Date: Mon, 13 Aug 2001 19:32:14 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: Re: IDE UDMA/ATA Suckage, or something else?
In-Reply-To: <E15WODu-00089l-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > You must disable IDE prefetch on the current versions of the AMD MP
> > > chipset, you may also need to enable "noapic".
> >
> > Unless I can do it with the kernel, I have no choice. The BIOS has no
> > prefetch setting (which, BTW, I had disabled on all my A7V133 boards).
> > So what about problems with non MP boards?
> 
> Well its entirely possible that the BIOS vendor did the right thing and
> made sure you couldnt turn it on. How does your box behave with noapic ?

I haven't had a chance to try it yet. I'll let the lists know when I do.

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
