Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUAMEFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 23:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAMEFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 23:05:39 -0500
Received: from neuromancer.legions.org ([66.12.11.163]:37508 "HELO
	mail.legions.org") by vger.kernel.org with SMTP id S263580AbUAMEF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 23:05:28 -0500
Date: Mon, 12 Jan 2004 22:05:25 -0600 (CST)
From: "Chris K. Engel" <morbie@legions.org>
To: Ben Collins <bcollins@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sun Type5 Mapping 2.4 -> 2.6
In-Reply-To: <20040113024708.GZ31486@phunnypharm.org>
Message-ID: <Pine.LNX.4.56.0401122200530.22986@cyberspace7.legions.org>
References: <Pine.LNX.4.56.0401121950030.18099@cyberspace7.legions.org>
 <20040113024708.GZ31486@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, I'm going to find the announcement for this, I'd love to see the
explanation for completely and blatantly trying to adhere uniformity
without at least a message in Documentation/Changes.

That's kind of... messed up.

---

Don't get me wrong, I have no problem with it whatsoever, it's just the
deployment that has me partially peturbed.


------------------------------------
Hier liegt ein Mann ganz obnegleich;
Im Leibe dick, an Suden reich.
Wir haben ihn in das Grab gesteckt,
Weil es uns dunkt er sei verreckt.
-PDQ Bach's Epitaph.
------------------------------------

Chris K. Engel

PS: Thank you all for the tip-offs. I feel like even more of a moron now.
^_^


On Mon, 12 Jan 2004, Ben Collins wrote:

> On Mon, Jan 12, 2004 at 07:54:02PM -0600, Chris K. Engel wrote:
> > I've noticed something strange.
> > When updating to 2.6.1, my type5's mapping was really, really set off.
> > Nothing would work, period. (And I've noticed an abundance of mapping
> > issues on non-US keyboard layouts.)
>
> Everything in 2.6 is an i386 key mapping. Switch your console key
> mapping to an i386 type, or just plain old disable the console key
> mapping and leave it up to the kernel (which is what I do).
>
> --
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> WatchGuard - http://www.watchguard.com/
>
