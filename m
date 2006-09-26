Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWIZVXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWIZVXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWIZVXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:23:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:64732 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932425AbWIZVXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:23:14 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: x86/x86-64 merge for 2.6.19
Date: Tue, 26 Sep 2006 23:23:10 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200609261244.43863.ak@suse.de> <200609262226.09418.ak@suse.de> <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262323.10190.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> That said, the merges with Andrew are also sometimes in the 150+ patch 
> range, and merging with other git trees can sometimes bring in even more. 
> So I'm not claiming any hard limits or anything like that, just that in 
> general it's nicer to get updates trickle in over time rather than all at 
> once.
> 
> I suspect this was mostly a one-time startup-event.

It accumulated a bit because the .18 cycle was relatively long
(and i also did more patches that usual myself, but most of that
was just cleanup and general janitor work) 

I normally do the main bulk the two week merge window and only important
stuff afterwards (usually two or three smaller merges with more stuff
and then only critical bug fixes in small batches until release). 

You want merges more often or more spaced out?

I currently planned to do better spaced out posting for review
at least (to not overwhelm the various mailing lists). It would
be possible to do the merge towards you shortly after that when
patches cooked a bit in -mm*. But it won't follow the two week window
all that much.

-Andi

