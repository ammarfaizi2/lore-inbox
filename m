Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312852AbSCVVot>; Fri, 22 Mar 2002 16:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSCVVoj>; Fri, 22 Mar 2002 16:44:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19719 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312852AbSCVVoa>; Fri, 22 Mar 2002 16:44:30 -0500
Date: Fri, 22 Mar 2002 22:44:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Blais <blais@discreet.com>
Cc: Martin Blais <blais@IRO.UMontreal.CA>, linux-kernel@vger.kernel.org
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Message-ID: <20020322214413.GG16382@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there> <20020322092712.GA233@elf.ucw.cz> <200203221829.NAA22671161@cuba.discreet.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It would be great to somehow split patches before feeding them to the
> > patch. If you have one big hunk, and it fails because of one letter
> > added somewhere in file, it is *big pain* to find/kill offending
> > letter.
> 
> oops.. sorry Pavel, never mind previous email, i got it now (brain is slowly 
> booting this morning).

Problem is that sometimes even one hunk is too much.

> that seems more like a patch problem/improvement request. i wouldn't do the 
> patch myself... however, with the rejected hunks problem, i wonder if it is 
> at all possible to avoid implementing patch functionality in the diffing tool 
> itself.

Question is how to do it in patch. Even one *long line* can be too
much, and then your horizontal highlight would come very handy.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
