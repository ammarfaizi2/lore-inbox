Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135178AbRDLNMq>; Thu, 12 Apr 2001 09:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135179AbRDLNMg>; Thu, 12 Apr 2001 09:12:36 -0400
Received: from ns.suse.de ([213.95.15.193]:24070 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135178AbRDLNMY>;
	Thu, 12 Apr 2001 09:12:24 -0400
Date: Thu, 12 Apr 2001 15:12:23 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: <esr@thyrsus.com>, Aaron Lehmann <aaronl@vitelus.com>,
        Michael Elizabeth Chastain <chastain@cygnus.com>,
        <kbuild-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
In-Reply-To: <01041206002400.19748@gopnik.dom-duraki>
Message-ID: <Pine.LNX.4.30.0104121506110.13766-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Steven Cole wrote:

> Excuse me, but this seems to be something of a red herring.
> ...
>  Adding seconds or tens of seconds at this time on 2001 hardware will
> seem very moot by the time 2.5/2.6 is at the point 2.4.x is now.

Adding tens of seconds per build is not acceptable when you're building
a lot of kernels each day.

The beginning of this thread showed a 15 second stall on an Athlon 800,
vs a 1 second startup for the old system. The point now is that
Eric _is_ working on improving the performance. (Which was probably
in another post you missed).

> If you haven't seen my posts here before, I just joined this list last night.

Find a list archive, read the beginning of the thread.

regards,

Dave.

