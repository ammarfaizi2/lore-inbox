Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTE3WpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTE3WpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:45:24 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:45484 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264015AbTE3WpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:45:23 -0400
Date: Sat, 31 May 2003 00:58:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530225839.GI3308@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.44.0305301546580.3089-100000@home.transmeta.com> <20030530225504.GK9502@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530225504.GK9502@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 23:55:04 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> FWIW, I'd ran Lindent maybe 10 times or so - only in truly appalling cases
> when it hurts just looking at the code (drivers/block/paride, mostly - just
> take a look at it in 2.4).  Usually it's more of "I change that function;
> might as well reindent it" and it's done manually.

A policy that I like.  Ugly code is a big red flag that noone with
taste looked at this function in a while.  Handle with care and watch
your back.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
