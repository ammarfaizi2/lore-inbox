Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWBJWnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWBJWnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBJWnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:43:19 -0500
Received: from mail.gmx.de ([213.165.64.21]:2999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751389AbWBJWnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:43:18 -0500
X-Authenticated: #428038
Date: Fri, 10 Feb 2006 23:43:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: lkml@dervishd.net, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210224313.GD4265@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	lkml@dervishd.net, peter.read@gmail.com, mj@ucw.cz,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD> <43EC88B8.nailISDH1Q8XR@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC88B8.nailISDH1Q8XR@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-10:

> DervishD <lkml@dervishd.net> wrote:
> 
> >     My system is clueless, too! If I write a CD before plugging my
> > USB storage device, my CD writer is on 0,0,0. If I plug my USB
> > storage device *before* doing any access, my cdwriter is on 1,0,0.
> > Pretty stable.
> 
> You are referring to a conceptional problem in the Linux kernel.
> If you are unhappy with this, send a bug report to the related
> people.
> 
> This does not belong to libscg.

No. You're shifting the blame, and this won't work here. You claim b,t,l
were more stable than device node naming (which is untrue, as proven),
and if it isn't because the assumptions in libscg don't hold, it's
still someone else's fault. In doubt, everything that isn't Solaris or
SchilliX is badly designed, a bug, or whatever.

That's a pretty egocentric view.

-- 
Matthias Andree
