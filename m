Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268811AbTGOQM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268747AbTGOQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:11:35 -0400
Received: from [64.105.205.123] ([64.105.205.123]:37693 "HELO borg.org")
	by vger.kernel.org with SMTP id S268736AbTGOQIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:08:46 -0400
Date: Tue, 15 Jul 2003 12:23:36 -0400
From: Kent Borg <kentborg@borg.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030715122336.B12505@borg.org>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030713133517.GD19132@mail.jlokier.co.uk>; from jamie@shareable.org on Sun, Jul 13, 2003 at 02:35:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 02:35:17PM +0100, Jamie Lokier wrote:
> I'd be inclined to initiate suspend-to-disk when the laptop's lid is
> closed

Please don't suspend my notebook when the lid is closed.  I frequently
want it running when closed.  It is OK to turn off the backlight when
closed (which my Vaio does), but don't show down my CPU or network
just because I am not typing or looking at the screen.


-kb, the Kent who sometimes just closes his notebook before hopping
off the bus, and who sometimes plugs it in to power and network when
at home but leaves the lid closed.
