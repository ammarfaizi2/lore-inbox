Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVDGVHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVDGVHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVDGVHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:07:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58631 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262600AbVDGVH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:07:27 -0400
Date: Thu, 7 Apr 2005 23:07:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Josselin Mouette <joss@debian.org>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407210722.GC4325@stusta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Josselin Mouette <joss@debian.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404190518.GA17087@wonderland.linux.it> <20050404193204.GD4087@stusta.de> <1112709907.30856.17.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112709907.30856.17.camel@silicium.ccc.cea.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 04:05:07PM +0200, Josselin Mouette wrote:
> Le lundi 04 avril 2005 à 21:32 +0200, Adrian Bunk a écrit :
> > On Mon, Apr 04, 2005 at 09:05:18PM +0200, Marco d'Itri wrote:
> > > On Apr 04, Greg KH <greg@kroah.com> wrote:
> > > 
> > > > What if we don't want to do so?  I know I personally posted a solution
> > > Then probably the extremists in Debian will manage to kill your driver,
> > > like they did with tg3 and others.
> > 
> > And as they are doing with e.g. the complete gcc documentation.
> > 
> > No documentation for the C compiler (not even a documentation of the 
> > options) will be neither fun for the users of Debian nor for the Debian 
> > maintainers - but it's the future of Debian...
> 
> You are mixing apples and oranges. The fact that the GFDL sucks has
> nothing to do with the firmware issue. With the current situation of
> firmwares in the kernel, it is illegal to redistribute binary images of
> the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
> be willing to distribute such binary images, but it isn't our problem.
>...


It's a grey area.

debian-legal did pick one of the possible opinions on this matter.


The similarities between the GFDL and the firmware discussion can be 
described with the following two questions:


Is it true, that the removal of much of the documentation in Debian is 
scheduled soon because it's covered by the GFDL, that this is called an 
"editorial change", and that Debian doesn't actually care that this will 
e.g. remove all documentation about available options of the standard C 
compiler used by and shipped with Debian?

Is it true, that Debian will leave users with hardware affected by the 
firmware problem without a working installer in Debian 3.1?


The point is simply, that Debian does more and more look dogmatic at 
it's definition of "free software" without caring about the effects to 
it's users.


As a contrast, read the discussion between Christoph and Arjan in a part 
of this thread how to move firmware out of kernel drivers without 
problems for the users. This might not happen today, but it's better for 
the users.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

