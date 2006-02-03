Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945913AbWBCT2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbWBCT2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWBCT2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:28:34 -0500
Received: from mail.gmx.net ([213.165.64.21]:55172 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030223AbWBCT2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:28:33 -0500
X-Authenticated: #428038
Date: Fri, 3 Feb 2006 20:28:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, cdwrite@other.debian.org,
       acahalan@gmail.com
Subject: Re: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203192827.GC18533@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, linux-kernel@vger.kernel.org,
	cdwrite@other.debian.org, acahalan@gmail.com
References: <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203182049.GB11083@merlin.emma.line.org> <43E3A19E.nail6A511N92B@burner> <20060203184240.GC11241@voodoo> <43E3AA95.nail6AV21A253@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E3AA95.nail6AV21A253@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-03:

> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> 
> > On 02/03/06 07:31:58PM +0100, Joerg Schilling wrote:
> > > Matthias Andree <matthias.andree@gmx.de> wrote:
> > > 
> > > > So patches to the rescue -- please review the patch below (for 2.01.01a05).
> > > > Note that GPL 2a and 2c apply, so you cannot merge a modified version of
> > > > my patch without adding a tag that you goofed my fixes.
> > > 
> > > OK, I did not look at it and I never will!
> > > 
> > > Jörg
> >
> > This is an excellent example to verify how bad cdrecord developent
> > is done.....
> 
> Well,
> 
> cdrecord is done as good as possible. 

Untrue. Proof: My patch makes it operate more smoothly on Linux.

> Note that if peope send a patch together with personal infringements or 
> untrue claims, the best I can do is to ignore alltogether.

Look who's talking, and what. Personal infringements? If you're
sensitive, my apologies, I didn't mean to insult you.

> I did spend a lot of time with a fruitful discussion with Matthias.
> Then Matthias started this thread.... It now seems like Matthias 
> does not like to be serious anymore.

I am absolutely serious about the patch and about my recent findings
after looking at libscg.

I just don't want my name tainted with accidents that happen during
integration because you don't have a recent Linux installation. The
RLIMIT_MEMLOCK was enough of an effort, my first patch would've worked,
too, hence the GPL.

> I am of course interested to make cdrecord better, but for the price
> of spending an ridiculously amount of time ob LKML.

Well, if you'd listened and attempted to understand our scanning
concerns, you'd probably have had libscg use a unified ATA:/SCSI:
namespace in Linux for 1½ years. OK, spilled milk.

-- 
Matthias Andree
