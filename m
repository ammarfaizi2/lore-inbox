Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTLTVrk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLTVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:47:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:11782 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261613AbTLTVre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:47:34 -0500
Date: Sat, 20 Dec 2003 22:58:48 +0100
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
Message-ID: <20031220215848.GA30057@hh.idb.hist.no>
References: <200312190314.13138.schwientek@web.de> <3FE2B717.7020502@convergence.de> <20031219213734.GA27975@irc.pl> <3FE3FC11.70009@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE3FC11.70009@wmich.edu>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 02:36:49AM -0500, Ed Sweetman wrote:
> 
> But, what's really the point in using X with matroxfb? 
In my case, the point is to run two instances of X, one on each
of the two framebuffers.  I can then have two simultaneous users,
each using one of the two framebuffers.  Two pc's in one!

> You lose half 
> your memory off the bat that X cannot access and you get no added 
> performance or anything.  
Another X accesses the other memory :-)

> It really does not seem worth it.  Use 
> matroxfb if you need to do fb stuff in a console without X.  Otherwise, 
> stick to just plain console and X and forget about matroxfb.

Sure - for single-user setups.

Helge Hafting
