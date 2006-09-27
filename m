Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030887AbWI0Vew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030887AbWI0Vew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030888AbWI0Vew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:34:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030887AbWI0Vev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:34:51 -0400
Date: Wed, 27 Sep 2006 23:34:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060927213443.GD25589@elf.ucw.cz>
References: <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz> <20060925160648.de96b6fa.akpm@osdl.org> <20060925232151.GA1896@elf.ucw.cz> <20060925172240.5c389c25.akpm@osdl.org> <20060926102434.GA2134@elf.ucw.cz> <20060926094607.815d126f.akpm@osdl.org> <20060927090902.GC24857@elf.ucw.cz> <20060927140808.2aece78e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927140808.2aece78e.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw
> 
> OK, that compiles.

Does it also help you find the problem?

> I think we should get this documented and merge it (or something like it) into
> mainline.  This is one area where it's worth investing in debugging tools.
> 
> If you agree, are we happy with it in its present form?

Well, I thought about it, but then I thought you would not like such a
patch. Yes, it certainly makes my life easier.
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
