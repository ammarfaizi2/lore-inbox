Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVDHSCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVDHSCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVDHSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:02:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:62089 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262904AbVDHSCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:02:25 -0400
Date: Fri, 8 Apr 2005 20:01:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Josselin Mouette <joss@debian.org>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408180109.GB15688@stusta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Josselin Mouette <joss@debian.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404190518.GA17087@wonderland.linux.it> <20050404193204.GD4087@stusta.de> <1112709907.30856.17.camel@silicium.ccc.cea.fr> <20050407210722.GC4325@stusta.de> <1112944920.11027.13.camel@silicium.ccc.cea.fr> <20050408173400.GA15688@stusta.de> <1112982171.5017.6.camel@mirchusko.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112982171.5017.6.camel@mirchusko.localnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 07:42:51PM +0200, Josselin Mouette wrote:
> Le vendredi 08 avril 2005 à 19:34 +0200, Adrian Bunk a écrit :
> > > When there are several possible interpretations, you have to pick up the
> > > more conservative one, as it's not up to us to make the interpretation,
> > > but to a court.
> > 
> > If Debian was at least consistent.
> > 
> > Why has Debian a much more liberal interpretation of MP3 patent issues 
> > than RedHat?
> 
> Because we already know that patents on MP3 decoders are not
> enforceable. Furthermore, the holders of these patents have repeatedly

How do you know the patents aren't enforceable?

> stated they won't ask for fees on MP3 decoders.

  http://www.mp3licensing.com/royalty/index.html

talks about 0.75 Dollar for a decoder.

> > How do you install Debian on a harddisk behind a SCSI controller who's 
> > driver was removed from the Debian kernels due to it's firmware?
> 
> Which SCSI controller are you talking about?

Quoting README.Debian of the Debian kernel sources:

<--  snip  -->

* QLA2XXX firmware, driver disabled:
  . drivers/scsi/qla2xxx/*_fw.c

<--  snip  -->

There are a few other SCSI controllers where even the Debian kernel 
sources still ship both the drivers and the firmware. I do not claim to 
understand the latter...

> > > Being careless in the definition of "free software" is a real disservice
> > > to users. It makes them rely on e.g. non-free documentation for everyday
> > > use.
> > >...
> > 
> > Documentation is "software"?
> 
> Sure.

Every book in my book shelf is software?

That doesn't match how people outside of Debian use the word "software".

> > Non-free documentation is better than no documentation.
> > 
> > Non-free software has several problems, but some of them like the right 
> > to do modifications are less important for documentation, since e.g. 
> > fixes for security bugs are not an issue.
> > 
> > Removing the available documentation without an equal replacement is a 
> > real disserve for your users.
> 
> GFDL documentation will still be available in the non-free archive.

Assuming you have an online connection and a friend told you how to 
manually edit your /etc/apt/sources.list for non-free.

But where's the documentation if you don't have an online connection but 
only the dozen binary CDs of Debian?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

