Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbRG0JhA>; Fri, 27 Jul 2001 05:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267898AbRG0Jgl>; Fri, 27 Jul 2001 05:36:41 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:13697 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267894AbRG0JgZ>; Fri, 27 Jul 2001 05:36:25 -0400
Message-ID: <3B613573.F4C36376@randomlogic.com>
Date: Fri, 27 Jul 2001 02:33:39 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Foerster <puckwork@madz.net>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Linx Kernel Source tree and metrics
In-Reply-To: <200107270917.f6R9HUt19989@antimatter.net> <3B61337C.D48F203A@randomlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Paul G. Allen" wrote:
> 
> Thomas Foerster wrote:
> >
> > Hi,
> >
> > > For those interested, I have run the kernel (2.4.2-2) through a program
> > > and generated extensive HTML reports including call trees, function and
> > > data declarations, source code, and metrics. I plan to upgrade this to
> > > the latest kernel and keep it up to date (as much as possible :), but I
> > > am a) working with a kernel that I know currently runs on my dual
> > > Athlon, and b) wanted to test this out and run it by the two lists
> > > first.
> >
> > > The URL is:
> >
> > > http://24.5.14.144:3000/linux-kernel
> >
> > [...]
> >
> > It's forwarded to "127.0.0.1:3000", so no one can connect?! ;-)
> >
> 
> That figures. I'm about ready, to give this router back to my company -
> I've had nothing but trouble since I got it. Things worked better when I
> just used a Linux firewall/router to do all my routing and forwarding.
> Arrgg!!
> 
> I'll see if I can make it listen to me and forward to the correct
> internal IP and port. (that's the right port, but the wrong IP by far!
> #8^)
> 

OK, try it now. (I really need another external IP/connection so I can
try these things out myself first :-)

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
