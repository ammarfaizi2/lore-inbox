Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUHZJ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUHZJ6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUHZJyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:54:08 -0400
Received: from witte.sonytel.be ([80.88.33.193]:479 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268034AbUHZIsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:48:31 -0400
Date: Thu, 26 Aug 2004 10:35:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Roman Zippel <zippel@linux-m68k.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Daniel Andersen <anddan@linux-user.net>,
       "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
       fraga@abusar.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <200408261109.43840.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.58.0408261034150.10582@waterleaf.sonytel.be>
References: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz>
 <147680000.1093445547@[10.10.2.4]> <Pine.LNX.4.61.0408252255320.12756@scrub.home>
 <200408261109.43840.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Denis Vlasenko wrote:
> > > My assumption would be that once 2.6.9 is released, it's not uber-stable
> > > immediately ... so it'd be nice to keep at least one minor rev back
> > > going on the bugfix stream (eg 2.6.8.X) .... for people who want an
> > > uber-stable kernel. Doing more than 1 back would indeed seem
> > > counter-productive.
> >
> > In this case it would make more sense to get 2.6.9.1 released as quickly
> > as possible instead of trying to fix old releases.
>
> Think about a user who can't risk moving to 2.6.9.1.
> [S]he wants to use 2.6.8.n+1 which have only one more fix.

Then that user can apply the single fix for the problem he's interested in.
People are doing that with whatever old (= not the latest) kernel they're
running right now.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
