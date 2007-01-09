Return-Path: <linux-kernel-owner+w=401wt.eu-S932178AbXAIQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbXAIQEq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbXAIQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:04:46 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:44919 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932178AbXAIQEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:04:45 -0500
Date: Tue, 9 Jan 2007 11:04:44 -0500
To: Dirk <d_i_r_k_@gmx.net>
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Jay Vaughan <jv@access-music.de>,
       Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
Message-ID: <20070109160444.GC17269@csclub.uwaterloo.ca>
References: <45A22D69.3010905@gmx.net> <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com> <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]> <45A24176.9080107@gmx.net> <45A2509F.3000901@aitel.hist.no> <45A264E1.3080603@gmx.net> <1168317631.3013.7.camel@localhost> <45A342AC.9080507@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A342AC.9080507@gmx.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 08:22:20AM +0100, Dirk wrote:
> If there is no problem with Linux gaming I should shut the hell up and 
> start buying all these Linux games I keep hearing about and seeing in 
> those TV commercials.

There is no problem with linux gaming.  There is a problem with game
development companies and their marketing decisions.  Unless you somehow
make linux have 100% compatible directx and able to natively execute
windows code, the game companies aren't going to give a @#$#.  They have
a limited budget and for them it is more important to aim for 99% of the
market than 100% of the market if it means saving 20 or 30% in
development costs.  Even if it saves 5% in development cost, it makes
sense financially.

Some companies of course realize that the installation base does not
always equal the gamer installation base and write portable code in the
first place using abstraction layers where needed, and stick to opengl
and such.  This is why quake, and other titles from ID are ported to
linux and mac and such.  Some companies believe the hype from microsoft
about directx and write for that instead, which makes the games not
portable to mac or linux or anything else.

The problem is not that linux doesn't have any decent stable api for
games.  The problem is that it isn't directx which is what a lot of
companies believe they want to use.

I play neverwinters nights on my linux system.  I have never seen it on
windows.  Linux uses opengl, while I have no idea if the windows version
is opengl or directx or maybe lets you pick (some games offer a choice
of rendering engine).  I do know the game runs great for the most part
even though my hardware is below the minimum specs if I was running on
windows (at least according to the box for the game).

--
Len Sorensen
