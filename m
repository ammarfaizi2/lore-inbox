Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTLJQIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTLJQIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:08:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:39345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263666AbTLJQIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:08:00 -0500
Date: Wed, 10 Dec 2003 08:07:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Maciej Zenczykowski <maze@cela.pl>, David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.10.10312100538320.3805-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.58.0312100745200.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100538320.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Andre Hedrick wrote:
>
> Lets have some fun now and play this game.

Sorry, you need to learn the rules before you can play.

> As principle author of the "taskfile transport", any an all operations
> using, storing, execution, transfering, copying, opening ... anything
> may not operate with non-source-published binary modules.

That's against the GPL, and you can't modify the terms of the license. At
most, you personally can say that you will not sue even when the license
isn't followed - you can tell people that as far as _you_ are concerned,
you can losen the license further, and that actually puts a legal onus on
_you_ but nobody else.

But while you have the right to say "I will not sue over this" and the GPL
doesn't care one whit, you can _not_ say "I have my own list of additional
requirements that would trigger copyright infringement".

> So everyone one with/sells a PVR, NAS, SAN, Laptop, Workstation, Server
> which uses IDE/ATA/SATA is forbidden to operate unless written terms of
> use are set forward.

"The act of running the Program is not restricted" according to the GPL,
and "You may not impose any further restrictions on the recipients'
exercise of the rights granted herein."

So basically you _cannot_ take rights away outside the ones the GPL
requires (which boil down to the requirement of having source available).

> We can kill Linux in minutes, shall we?

Trust me, when you said that the GPL is badly written, you have no clue
what you're talking about. It's a very solid license, and your rants about
it have no basis in fact. I personally actually like the OSL slightly
better in the way it was written (see opensource.org), but your arguments
against the GPL are just fundamentally wrong.

			Linus
