Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWBJWkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWBJWkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBJWkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:40:47 -0500
Received: from mail.gmx.net ([213.165.64.21]:54925 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750720AbWBJWkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:40:47 -0500
X-Authenticated: #428038
Date: Fri, 10 Feb 2006 23:40:42 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, peter.read@gmail.com, mj@ucw.cz,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210224042.GC4265@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, mj@ucw.cz, linux-kernel@vger.kernel.org,
	jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC887B.nailISDGC9CP5@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-10:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> > > 
> > > Dou you like to verify that you have no clue on SCSI?
> >
> > How does, for instance, libscg make sure that the b,t,l mappings are
> > hotplug invariant?
> >
> > How does libscg make sure that two external writers, say USB, retain
> > their b,t,l mappings if both are unplugged and then replugged in reverse
> > order, perhaps into different USB hubs?
> 
> Well, this is a deficit of the Linux kernel - not libscg.

I wrote this before, but to fresh up your memory, here again, different
wording:

Unless Solaris's behavior is mandated by a commonly accepted standard,
comparable in relevance to IEEE or IETF standards, it is not relevant
for Linux.

It is YOU who has to make that decision: support your cdrtools users who
chose Linux (which means: accepting its decisions and adjusting YOUR
code to work properly, and either file detailed, traceable and
comprehensible bug reports, or work around the bugs), or leave the Linux
users standing in the rain.

-- 
Matthias Andree
