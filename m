Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270783AbTGNUXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270792AbTGNUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:21:19 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:7045 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270776AbTGNUUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:20:19 -0400
Date: Tue, 15 Jul 2003 08:32:28 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
In-reply-to: <20030714202947.GH902@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058214747.3987.17.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz> <20030714201056.GB24964@ucw.cz>
 <1058214085.3986.4.camel@laptop-linux> <20030714202947.GH902@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fine by me. The whole point is to make debugging easier, not to bloat
the kernel. It would probably make sense to keep a debugging patch that
could be used to reinsert the code if a tricky problem arose, but that's
a long way off now, so not worth stressing about yet.

Regards,

Nigel

On Tue, 2003-07-15 at 08:29, Pavel Machek wrote:
> You won that bet. This kind of debugging stuff needs to be killed
> before merging with Linus.
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

