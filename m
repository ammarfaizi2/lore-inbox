Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbTGORND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269151AbTGORND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:13:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:918 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S269131AbTGORM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:12:59 -0400
Date: Tue, 15 Jul 2003 18:27:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kent Borg <kentborg@borg.org>
Cc: Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030715172729.GA1491@mail.jlokier.co.uk>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030715122336.B12505@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715122336.B12505@borg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Borg wrote:
> On Sun, Jul 13, 2003 at 02:35:17PM +0100, Jamie Lokier wrote:
> > I'd be inclined to initiate suspend-to-disk when the laptop's lid is
> > closed
> 
> Please don't suspend my notebook when the lid is closed.

keep reading...

> > or when I press the suspend button
    ~~

I.e. switch between those two modes according to how the laptop is
being used at the time.  When travelling I use the lid switch to
suspend (well I used to before I dropped it and broke the lid switch
:) - at home I use the button.

I'd hope that suspend-to-disk could be activated in the same way
(whatever way it is) that suspend-to-ram is now.

- Jamie
