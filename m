Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbRE2RCy>; Tue, 29 May 2001 13:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbRE2RBj>; Tue, 29 May 2001 13:01:39 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261173AbRE2Q7T>;
	Tue, 29 May 2001 12:59:19 -0400
Message-ID: <20010529010725.A19338@bug.ucw.cz>
Date: Tue, 29 May 2001 01:07:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: otto.wyss@bluewin.ch,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Console display in portrait mode with unusual dpi resolution
In-Reply-To: <3B1150DB.ADF2178A@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B1150DB.ADF2178A@bluewin.ch>; from Otto Wyss on Sun, May 27, 2001 at 09:09:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Overview: At business I just got a brand new EIZO 18" LCD display L675
> to test its usability for working in portrait mode to show a full A4
> page. These test were done on Windows NT4 but I'd really like to know
> how well Linux would have done. I'm going to describe all the obstacles
> I encountered on Windows so anybody may knows the corresponding answers
> for Linux. Maybe there are other problems on Linux?
> 
> 1. Obstacle
> While the EIZO L675 is mechanically turnable, it doesn't handle the
> landscape/portrait mode switch itself. [OFFTOPIC] Are the any other
> displays capable of this? [OFFTOPIC OFF] The turning software had to be
> ordered/paid separate (Pivot software). Of course the display should
> handle it itself, but until this happens a software solution is okay. Is
> there any software solution for Linux?
> I've heard there are graphics cards which handles the landscape/portrait
> mode themselves (i.e. ATI radeon). This is almost as good as if the
> display handles it, as long as if there are the corresponding drivers
> available. How about Linux drivers?
> PS. My good old monochrome portrait monitor from Apple (around 1990) is
> an fine example.

Things like iPAQ can do portrait/landscape switch, and it is handled
by modified Xserver. Agenda people will probably have similar hack.

Warning: it is going to be slow, and don't dream to use DRI.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
