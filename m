Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270770AbTGNUAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270755AbTGNUAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:00:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:51939 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270770AbTGNT4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:56:53 -0400
Date: Mon, 14 Jul 2003 22:10:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030714201056.GB24964@ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713193114.GD570@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 09:31:14PM +0200, Pavel Machek wrote:

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

How about making it to be any key?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
