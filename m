Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268827AbTGOQOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbTGOQOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:14:37 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:27570 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268827AbTGOQN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:13:26 -0400
Date: Tue, 15 Jul 2003 18:27:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kent Borg <kentborg@borg.org>
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030715162758.GD10399@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030715122336.B12505@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715122336.B12505@borg.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd be inclined to initiate suspend-to-disk when the laptop's lid is
> > closed
> 
> Please don't suspend my notebook when the lid is closed.  I frequently
> want it running when closed.  It is OK to turn off the backlight when
> closed (which my Vaio does), but don't show down my CPU or network
> just because I am not typing or looking at the screen.

Of course, this *needs* to be configurable (== handled by
userland). If you are using external keyboard/mouse you do not want
your notebook open. I hate HP for putting powerswitch so that you have
to open notebook to turn it on/off...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
