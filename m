Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbSIPPMS>; Mon, 16 Sep 2002 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSIPPMS>; Mon, 16 Sep 2002 11:12:18 -0400
Received: from dsl-213-023-040-192.arcor-ip.net ([213.23.40.192]:15239 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262113AbSIPPMR>;
	Mon, 16 Sep 2002 11:12:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 17:15:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <E17qejV-00008L-00@starship> <20020916090616.GF12364@suse.de>
In-Reply-To: <20020916090616.GF12364@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qxbC-0000JO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 11:06, Jens Axboe wrote:
> On Sun, Sep 15 2002, Daniel Phillips wrote:
> > > I did. Matt probably did. But I didn't see you fixing it with your
> > > debugger.
> > 
> > I am setting up the debugger to work on the DAC960.
> 
> See, even though I'm not fundamentally against using kernel debuggers, I
> think this is very wrong. Where are you now? You are just learning about
> the bio interface and the changes needed to make it run. And this is
> definitely the most wrong point to start using a debugger, and can only
> result in a dac960 that works by trial and error.

I am not using the debugger to learn about bio, I use LXR for that.  I
am using the debugger because of the nature of the bugs I expect and
already seen.  Jens, I have 27 years of professional programming
experience, you do not have to tell me when to use a debugger and when
not to.

-- 
Daniel
