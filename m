Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWGHLMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWGHLMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWGHLMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:12:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17615 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932327AbWGHLMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:12:44 -0400
Date: Sat, 8 Jul 2006 13:12:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Avuton Olrich <avuton@gmail.com>, Bojan Smojver <bojan@rexursive.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       jan@rychter.com, linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060708111226.GI1700@elf.ucw.cz>
References: <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <1152334708.2497.10.camel@coyote.rexursive.com> <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <3aa654a40607072133i55ffe0d1ke9f0905c6599864c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152334708.2497.10.camel@coyote.rexursive.com> <3aa654a40607072133i55ffe0d1ke9f0905c6599864c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Now... switching to uswsusp kernel parts will make it slightly harder
> >to install in the short term (messing with initrd). OTOH there's at
> >least _chance_ to get to the point where suspend "just works" in
> >Linux, in the long term...
> 
> Long term being the key words. When will uswsusp be concidered 'rock
> solid'? 2008+? Suspend2 is rock solid _today_. Imagine a world where

uswsusp is probably going to be used for SUSE10.2, so it will have to
be solid at that point. And SUSE10.2 is going to be
end-of-2006/early-2007, IIRC.

> Linux drivers were as reliable as swsusp (granted I tried to get
> uswsusp working and I gave up before messing with the initrd stuff).

Can I get proper bug report?

> In order for uswsusp to make Suspend2 obsolete, it would have to *at
> least* support what Suspend2 does. Unfortunately, that isn't the case
> right now.

Suspend2 does not have all the features uswsusp has, and uswsusp does
not have all the features suspend2 has.

If you really miss some feature in uswsusp, please help us with
coding...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
