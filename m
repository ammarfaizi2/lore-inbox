Return-Path: <linux-kernel-owner+w=401wt.eu-S1751112AbXAIHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbXAIHAS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbXAIHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:00:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4556 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751112AbXAIHAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:00:16 -0500
Date: Tue, 9 Jan 2007 08:00:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dirk <d_i_r_k_@gmx.net>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Jay Vaughan <jv@access-music.de>,
       Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
Message-ID: <20070109070019.GJ25007@stusta.de>
References: <45A22D69.3010905@gmx.net> <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com> <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]> <45A24176.9080107@gmx.net> <45A2509F.3000901@aitel.hist.no> <45A264E1.3080603@gmx.net> <20070108195714.GA6167@stusta.de> <45A34146.3000709@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A34146.3000709@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 08:16:22AM +0100, Dirk wrote:
> Adrian Bunk wrote:
> >On Mon, Jan 08, 2007 at 04:36:01PM +0100, Dirk wrote:
> >>Helge Hafting wrote:
> >>...
> >>>Either _you_ code your game interface yourself, or you fund
> >>>some developers to do it for you. It is that simple.  You can
> >>>of course come here and ask advice about how to do it
> >>>and what parts will be accepted into the kernel and what parts
> >>>must stay outside it.
> >>>
> >>>This is not the place to post an idea and then expect someone
> >>>to actually program it.  This is the place where you may discuss
> >>>an idea, and then find out if Linus might accept your patch - or not!
> >>>
> >>>Helge Hafting
> >>Alright. I came to discuss an idea I had
> >
> >Open source does not work by telling about some seemingly good idea you 
> >had and expecting other people to implement your idea.
> >
> >Open source works by you implementing your idea.
> >
> >Try it yourself, and you will see the technical problems of your idea
> >(e.g. porting userrspace code to the stack-limited kernel or crashing 
> >the whole computer with bugs in the libraries) yourself.
> >
> >>because I realized that 
> >>installing Windows and running Linux in VMware is the only _fun_ way to 
> >>play "real" Games and have Linux at the same time.
> >>
> >>And everyone who says I'm a troll doesn't like Games or simple things.
> >
> >You talk as if you knew everything about games on Windows, but you seem 
> >to not even have heard of Wine or Cedega?
> 
> I tried to get WoW installed with Cedega 5.2.9 for two days now.

There are many reports that WoW runs fine under Wine [1].

> Cedega is not a replacement for ports. And it does not encourage ports.
>...

And what should encourage ports?
It's not that all people developing software for Windows were idiots who 
don't know what technologies Linux offers.

Remember Loki as an example that the market for games under Linux isn't 
big enough.

And remember Picasa as a success story for Wine - exactly because a port 
would have required too much effort for developers that were busy with 
other things.

> Dirk

cu
Adrian

[1] http://appdb.winehq.org/appview.php?iAppId=1922

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

