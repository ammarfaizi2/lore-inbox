Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbRE0ABZ>; Sat, 26 May 2001 20:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbRE0ABQ>; Sat, 26 May 2001 20:01:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20146 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262663AbRE0ABC>;
	Sat, 26 May 2001 20:01:02 -0400
Message-ID: <20010525203944.B15304@bug.ucw.cz>
Date: Fri, 25 May 2001 20:39:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Scott Anderson <scott_anderson@mvista.com>,
        David Weinehall <tao@acc.umu.se>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105200957500.323-100000@mikeg.weiden.de> <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva> <20010520235409.G2647@bug.ucw.cz> <20010521223212.C4934@khan.acc.umu.se> <3B0BF8B6.D7940FA3@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B0BF8B6.D7940FA3@mvista.com>; from Scott Anderson on Wed, May 23, 2001 at 05:51:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > IMVHO every developer involved in memory-management (and indeed, any
> > software development; the authors of ntpd comes in mind here) should
> > have a 386 with 4MB of RAM and some 16MB of swap. Nowadays I have the
> > luxury of a 486 with 8MB of RAM and 32MB of swap as a firewall, but it's
> > still a pain to work with.
> 
> If you really want to have fun, remove all swap...

My handheld has 12MB ram, no swap ;-), and that's pretty big machine
for handheld.
								Pavel
PS: Swapping on flash disk is bad idea, right?
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
