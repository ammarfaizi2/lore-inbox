Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRIJOgE>; Mon, 10 Sep 2001 10:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRIJOfy>; Mon, 10 Sep 2001 10:35:54 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S270947AbRIJOfq>;
	Mon, 10 Sep 2001 10:35:46 -0400
Message-ID: <20010910163515.C141@bug.ucw.cz>
Date: Mon, 10 Sep 2001 16:35:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ross Vandegrift <ross@willow.seitz.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010910092010.A22194@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010910092010.A22194@willow.seitz.com>; from Ross Vandegrift on Mon, Sep 10, 2001 at 09:20:10AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could someone network boot machine using netware,
> > capture whole session using 
> > 
> > tcpdump -xi eth0 
> > 
> > and send results to me? It should be rather easy to emulate initial
> > handshake and use mars (netware emulator) to boot workstation...
> 
> My employer uses RPL on a fairly large number of Netware DOS systems.
> When I get to work after school this afternoon, I'd be more than happy to
> grab a dump fo you.

Okay, never minds, I figured out how to configure mars, and to my very
big surprise, it seems to work. (I can boot freedos).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
