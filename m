Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267214AbSLKQrd>; Wed, 11 Dec 2002 11:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLKQrd>; Wed, 11 Dec 2002 11:47:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8601 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267214AbSLKQrc>;
	Wed, 11 Dec 2002 11:47:32 -0500
Date: Wed, 11 Dec 2002 11:53:57 -0500 (EST)
From: Richard A Nelson <cowboy@debian.org>
X-X-Sender: cowboy@badlands.lexington.ibm.com
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IBM spamms me with error messages
In-Reply-To: <200212110258.gBB2wXCb025160@badlands.lexington.ibm.com>
Message-ID: <Pine.LNX.4.50.0212111148210.24497-100000@badlands.lexington.ibm.com>
References: <20021210205611.GH20049@atrey.karlin.mff.cuni.cz>
 <200212110258.gBB2wXCb025160@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, David S. Miller wrote:

> Pavel, you're not the only person seeing this, and you're
> certainly not the only one sending emails to IBM's postmasters
> asking them to fix this.
>
> The lack of any response or actions by IBM's postmasters is certainly
> quite disturbing.  Is there that much red tape at the company? :-)

At times, yes :(

I've not yet traced this fully, but it looks like it might be the RSCS
gateway in action - I'll try to get the relevant folks to look at it.

Unfortunately, there are several groups involved - AT&T handles the
exterior gateway servers, another group handles the Lotus gateways,
and I beleive a third does the ip->rscs(mainframe) gateway.

-- 
Rick Nelson
Now I know someone out there is going to claim, "Well then, UNIX is intuitive,
because you only need to learn 5000 commands, and then everything else follows
from that! Har har har!"
	-- Andy Bates on "intuitive interfaces", slightly defending Macs
