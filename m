Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbSJLMhp>; Sat, 12 Oct 2002 08:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261165AbSJLMho>; Sat, 12 Oct 2002 08:37:44 -0400
Received: from services.cam.org ([198.73.180.252]:40916 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261158AbSJLMhm>;
	Sat, 12 Oct 2002 08:37:42 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: Linux v2.5.42
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sat, 12 Oct 2002 08:37:38 -0400
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021012123739.E4D284B43@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
> stand.  I'm not using any kind of volume management personally, so I just
> don't have the background or inclination to walk through the patches and
> make that kind of decision. My non-scientific opinion is that it looks
> like the EVMS code is going to be merged, but ..
> 
> Alan, Jens, Christoph, others - this is going to be an area where I need
> input from people I know, and preferably also help merging. I've been
> happy to see the EVMS patches being discussed on linux-kernel, and I just
> wanted to let people know that this needs outside help.

I support a SAP system (so far on solaris) at work.  I make extensive use
of a volume manager there.  On linux I have tried both LVM1 and EVMS.  I
stopped using LVM1 the thrid time it caused me to restore after a clean 
boot...  This problem may well have been fixed in LVM2 - I have not used it.
On the other had EVMS has never scrambled my disks.  It also offers more
options, including an encapsulated LVM1.  From my perspective EVMS wins.

Ed Tomlinson
