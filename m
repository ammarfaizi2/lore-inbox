Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263099AbTCWTN7>; Sun, 23 Mar 2003 14:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263148AbTCWTN7>; Sun, 23 Mar 2003 14:13:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34308 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263099AbTCWTN6>; Sun, 23 Mar 2003 14:13:58 -0500
Date: Sun, 23 Mar 2003 20:25:03 +0100
From: Martin Mares <mj@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323192503.GA14181@atrey.karlin.mff.cuni.cz>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com> <1047923841.1600.3.camel@laptop.fenrus.com> <20030317182040.GA2145@louise.pinerecords.com> <20030317182709.GA27116@gtf.org> <20030321211708.GC12211@zaurus.ucw.cz> <20030323110052.5267cba8.skraw@ithnet.com> <3E7DB99B.5050509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7DB99B.5050509@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

> I think you misunderstand my point:  there was a patch posted which 
> fixes the ptrace issue.  If you want to fix your kernel, there are two 
> options:  either you are capable enough apply that patch yourself, 
> otherwise get a kernel update from a vendor.

Sorry, but you seem to forget that a significant amount of people use
kernel.org kernels, but don't monitor LKML nor are able to choose from
the various patches floating there the most appropriate fix.

If 2.4.21 were expected in a few days, it would make sense to delay the
fix, but this doesn't seem to be the case, so I think that a hot-fix
really should be released quickly (either as 2.4.20.1 or 2.4.21)

> As for Alan, his task was easier:  Guess how many patches are in 2.2.25? 
>  One.  ;-)

And why couldn't it be the same for 2.4.21?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The better the better, the better the bet.
