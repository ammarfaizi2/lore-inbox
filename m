Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTLNLC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 06:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTLNLC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 06:02:57 -0500
Received: from gprs146-5.eurotel.cz ([160.218.146.5]:59008 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261522AbTLNLC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 06:02:56 -0500
Date: Sun, 14 Dec 2003 12:03:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Can swsusp 2.0 be merged into the 2.4 tree
Message-ID: <20031214110347.GD318@elf.ucw.cz>
References: <200312110537.17496.mhf@linuxmail.org> <20031212192252.GA465@elf.ucw.cz> <1071376690.2187.25.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071376690.2187.25.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> That's a bit rough, isn't it Pavel? I fully agree that the power
> management support in 2.4 is incomplete (just as is the case in 2.6),
> but there is power management support in 2.4, and it is being used.

Okay, I was a bit rough. Anyway pm support in 2.4 can not be made
complete by simply fixing all the drivers (unlike 2.6). I know that it
can be made to work pretty well for a lot of user, but I still do not
think that makes it suitable for 2.4 merge.
								Pavel

> Regards,
> 
> Nigel
> 
> On Sat, 2003-12-13 at 08:22, Pavel Machek wrote:
> > Hi!
> > 
> > > swsusp is useful feature also for 2.4. Could this please be merged.
> > 
> > 2.4 has no driver model => swsusp for 2.4 is a hack. Its nice and
> > working, but it is still a hack.
> > 							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
