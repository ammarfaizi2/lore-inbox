Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVDHRf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVDHRf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVDHReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:34:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262895AbVDHReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:34:04 -0400
Date: Fri, 8 Apr 2005 19:34:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Josselin Mouette <joss@debian.org>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408173400.GA15688@stusta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Josselin Mouette <joss@debian.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404190518.GA17087@wonderland.linux.it> <20050404193204.GD4087@stusta.de> <1112709907.30856.17.camel@silicium.ccc.cea.fr> <20050407210722.GC4325@stusta.de> <1112944920.11027.13.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112944920.11027.13.camel@silicium.ccc.cea.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 09:22:00AM +0200, Josselin Mouette wrote:
> Le jeudi 07 avril 2005 à 23:07 +0200, Adrian Bunk a écrit :
> > > You are mixing apples and oranges. The fact that the GFDL sucks has
> > > nothing to do with the firmware issue. With the current situation of
> > > firmwares in the kernel, it is illegal to redistribute binary images of
> > > the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
> > > be willing to distribute such binary images, but it isn't our problem.
> > 
> > It's a grey area.
> > 
> > debian-legal did pick one of the possible opinions on this matter.
> 
> When there are several possible interpretations, you have to pick up the
> more conservative one, as it's not up to us to make the interpretation,
> but to a court.


If Debian was at least consistent.

Why has Debian a much more liberal interpretation of MP3 patent issues 
than RedHat?


>...
> Instead of babbling, some people have started to discuss this with
> upstream, and are trying to come up with a GPLed documentation for GCC.
> This is much more constructive than repeating again and again "Bleh,
> Debian are a bunch of bigots who don't care of the compiler being
> documented."


Will the replacement documentation for all affected software be 
available before the GFDL documentation gets removed?

At least theoretically, the users are a priority for Debian equally to 
free software.


> > Is it true, that Debian will leave users with hardware affected by the 
> > firmware problem without a working installer in Debian 3.1?
> 
> The case of hardware really needing a firwmare to work *and* needed at
> installation time is rare. I've only heard of some tg3-based cards. Most
> of them will work without the firmware, and for the few remaining ones,
> it only means network installation won't work.


How do you install Debian on a harddisk behind a SCSI controller who's 
driver was removed from the Debian kernels due to it's firmware?


> > The point is simply, that Debian does more and more look dogmatic at 
> > it's definition of "free software" without caring about the effects to 
> > it's users.
> 
> Being careless in the definition of "free software" is a real disservice
> to users. It makes them rely on e.g. non-free documentation for everyday
> use.
>...


Documentation is "software"?

Non-free documentation is better than no documentation.

Non-free software has several problems, but some of them like the right 
to do modifications are less important for documentation, since e.g. 
fixes for security bugs are not an issue.

Removing the available documentation without an equal replacement is a 
real disserve for your users.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

