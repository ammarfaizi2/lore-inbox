Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWGGXVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWGGXVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWGGXTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34237 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932372AbWGGXTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:19:40 -0400
Date: Sat, 8 Jul 2006 01:19:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dirk husemann <hud@zurich.ibm.com>
Cc: Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
Message-ID: <20060707231925.GB1746@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com> <20060707135031.GA4239@ucw.cz> <44AE77C8.2040909@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AE77C8.2040909@zurich.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>  Pavel> I do not think suspend2 works on more machines than in-kernel
> >>  Pavel> swsusp. Problems are in drivers, and drivers are shared.
> >>
> >>  Pavel> That means that if you have machine where suspend2 works and
> >>  Pavel> swsusp does not, please tell me. I do not think there are many
> >>  Pavel> of them.
> >>
> >> Accept the facts -- for some reason, there is a fairly large user base
> >> that goes to all the bother of using suspend2, which requires
> >>     
> > ...
> >   
> >> That is a fact, and all the hand waving won't change it.
> >>     
> >
> > Users like suspend2 eye candy => swsusp must be unreliable?
> >   
> oh, come on. that's a pretty cheap argument. let me tell you i tried
> swsusp (admittedly a while ago) couldn't get it to run reliably on

Can you retry with recent version and generate proper bugreport if it
is still broken?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
