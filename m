Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbTKJTZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTKJTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:25:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:40373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264076AbTKJTZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:25:46 -0500
Date: Mon, 10 Nov 2003 11:25:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.3.96.1031110135419.6278B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311101118490.31529-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Nov 2003, Bill Davidsen wrote:
> 
> I take it that if the IDE maintainer and you don't use a device it will
> not be supported in the future?

You take it wrong.

However, I'll spell this out in small words, since you don't seem to be 
getting it:

	open source is not about me and the IDE maintainer doing all the 
	work.

	Nobody seems to be sending patches either to fix ide-scsi _or_ 
	those other devices you claim you're so interested in.

	I fixed the IDE CD driver to work. I care. The fact that nobody 
	else seems to care about anything else is the final word.

Do you get it? It's all about technology. I don't hate you. Really. I'm 
not here to try to make things difficult for you. But also, I'm not here 
to be your personal slave, and if you think I am, you're just WRONG and 
you should just realize that I don't care about what you think.

> I admit I can't understand why 2.6 supports old NICs and motherboard
> chipsets which haven't been made in five years, and then deliberately
> desupports devices which did work and which are available at computer
> stores and mail order today.

Those other devices have people MAINTAINING THEM AND CARING!

What's so horribly hard to understand about this? You're barking up the 
wrong tree.

Again, I tell you once more:

 - for burning IDE CD-ROM's you should use the IDE driver. Not ide-scsi. 
   End of discussion. It's a supported and _improved_ situation from where 
   it was in 2.4.x.

 - For all those devices you claim exists, show me the patches. Nobody 
   broke ide-scsi on purpose - but the fact is that nobody also ever came 
   forward and _fixed_ it. 

Get it now? 

So come back to me when you find somebody who cares enough about the 
devices you claim exists enough that he actually _does_ something about 
it. Until then, there's just no point in bothering me. Comprende?

		Linus

