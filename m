Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319506AbSILV3o>; Thu, 12 Sep 2002 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319509AbSILV3o>; Thu, 12 Sep 2002 17:29:44 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64135 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319506AbSILV3k>;
	Thu, 12 Sep 2002 17:29:40 -0400
Date: Thu, 12 Sep 2002 23:31:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Gerhard Mack <gmack@innerfire.net>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Spamcop
Message-ID: <20020912233115.A24954@ucw.cz>
References: <20020912211056.J4739@flint.arm.linux.org.uk> <Pine.LNX.4.44.0209121657590.27346-100000@innerfire.net> <20020912141338.B14230@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020912141338.B14230@work.bitmover.com>; from lm@bitmover.com on Thu, Sep 12, 2002 at 02:13:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 02:13:38PM -0700, Larry McVoy wrote:

> On Thu, Sep 12, 2002 at 05:06:15PM -0400, Gerhard Mack wrote:
> > Check your logs .. it looks like maybe somone was sending spoofed
> > requests?  Either that or somone was a total dumbass.
> > 
> > I wonder how hard it is to generate enough requests to get somone listed.
> 
> In the for what it is worth department, I got mail from "esr@thyrus.org"
> with a subject of "cool game" or something like that, and it was obviously
> forged.  It's interesting that they are getting smart enough to make it look
> like it comes from someone that you've communicated with in the past.  Sigh.

That's an internet worm, called klez. I'm getting more than 10 of these daily.
Each is a meg of data. And I'm also getting responses from various
mailservers which received the worm with my From: address. It generates
both From: and To: randomly based on the victims Outlook addressbook.

-- 
Vojtech Pavlik
SuSE Labs
