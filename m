Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSIPJCE>; Mon, 16 Sep 2002 05:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSIPJCE>; Mon, 16 Sep 2002 05:02:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50832 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261246AbSIPJCD>;
	Mon, 16 Sep 2002 05:02:03 -0400
Date: Mon, 16 Sep 2002 11:06:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020916090616.GF12364@suse.de>
References: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <E17qejV-00008L-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17qejV-00008L-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15 2002, Daniel Phillips wrote:
> > I did. Matt probably did. But I didn't see you fixing it with your
> > debugger.
> 
> I am setting up the debugger to work on the DAC960.

See, even though I'm not fundamentally against using kernel debuggers, I
think this is very wrong. Where are you now? You are just learning about
the bio interface and the changes needed to make it run. And this is
definitely the most wrong point to start using a debugger, and can only
result in a dac960 that works by trial and error.

-- 
Jens Axboe

