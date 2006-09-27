Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031206AbWI0W7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031206AbWI0W7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031202AbWI0W7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:59:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031200AbWI0W6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:58:52 -0400
Date: Wed, 27 Sep 2006 15:58:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060927155831.dc2a8588.akpm@osdl.org>
In-Reply-To: <20060927213443.GD25589@elf.ucw.cz>
References: <1159220043.12814.30.camel@nigel.suspend2.net>
	<20060925144558.878c5374.akpm@osdl.org>
	<20060925224500.GB2540@elf.ucw.cz>
	<20060925160648.de96b6fa.akpm@osdl.org>
	<20060925232151.GA1896@elf.ucw.cz>
	<20060925172240.5c389c25.akpm@osdl.org>
	<20060926102434.GA2134@elf.ucw.cz>
	<20060926094607.815d126f.akpm@osdl.org>
	<20060927090902.GC24857@elf.ucw.cz>
	<20060927140808.2aece78e.akpm@osdl.org>
	<20060927213443.GD25589@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 23:34:43 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw
> > 
> > OK, that compiles.
> 
> Does it also help you find the problem?

argh.  pooter is five miles away and attention span is infinitesimal.

> > I think we should get this documented and merge it (or something like it) into
> > mainline.  This is one area where it's worth investing in debugging tools.
> > 
> > If you agree, are we happy with it in its present form?
> 
> Well, I thought about it, but then I thought you would not like such a
> patch. Yes, it certainly makes my life easier.

OK, let's run with it.  If that's the final version.  Perhaps add some nice
words in the documentation?
