Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTGMUpn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270391AbTGMUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:45:42 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:7610 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270385AbTGMUpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:45:34 -0400
Date: Mon, 14 Jul 2003 09:01:11 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <20030713193114.GD570@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058130071.1829.2.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Escape is more intuitively obvious though - I would expect the suspend
button to only start a suspend. And the idea of escape cancelling
anything is well in-grained in peoples' minds.

Of course the other advantage is that reading lid & button switches adds
more code (To implement and to configure - the functions of those keys
ought to be optional?)

Regards,

Nigel

On Mon, 2003-07-14 at 07:31, Pavel Machek wrote:
> Hi!
> 
> > > And no escape. Doing something from keyboard is *ugly*. Magic sysrq is
> > > ugly, too, but its usefull enough to outweight that.
> > 
> > Can't you just use the Suspend button? :)
> 
> At least that's less ugly than Escape. If it is the same button that
> would wake machine up when it finished suspend... I guess that makes
> sense.
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

