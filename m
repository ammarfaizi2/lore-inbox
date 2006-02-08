Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422912AbWBIRG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422912AbWBIRG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422891AbWBIRGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:06:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41995 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965234AbWBIRGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:06:37 -0500
Date: Wed, 8 Feb 2006 22:13:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       linux-kernel@vger.kernel.org, cdwrite@other.debian.org,
       acahalan@gmail.com
Subject: Re: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060208221305.GF2353@ucw.cz>
References: <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203182049.GB11083@merlin.emma.line.org> <43E3A19E.nail6A511N92B@burner> <20060203184240.GC11241@voodoo> <43E3AA95.nail6AV21A253@burner> <20060203192827.GC18533@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060203192827.GC18533@merlin.emma.line.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > So patches to the rescue -- please review the patch below (for 2.01.01a05).
> > > > > Note that GPL 2a and 2c apply, so you cannot merge a modified version of
> > > > > my patch without adding a tag that you goofed my fixes.
> > > > 
> > > > OK, I did not look at it and I never will!
> > > > 
> > > > Jörg
> > >
> > > This is an excellent example to verify how bad cdrecord developent
> > > is done.....
> > 
> > Well,
> > 
> > cdrecord is done as good as possible. 
> 
> Untrue. Proof: My patch makes it operate more smoothly on Linux.
...
> I just don't want my name tainted with accidents that happen during
> integration because you don't have a recent Linux installation. The
> RLIMIT_MEMLOCK was enough of an effort, my first patch would've worked,
> too, hence the GPL.

Well, mailing patch with notice that it is not okay to modify it is
strange behaviour, and if I was Joerg, I'd just drop that patch, too.

If you really want the patch applied, submit it anonymously or
something like that.

							Pavel
-- 
Thanks, Sharp!
