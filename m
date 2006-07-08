Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWGHMwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWGHMwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWGHMwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:52:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35476 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964797AbWGHMwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:52:16 -0400
Date: Sat, 8 Jul 2006 14:52:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060708125200.GA1762@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <200607081342.40686.ncunningham@linuxmail.org> <200607081238.16753.rjw@sisk.pl> <200607082131.47832.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607082131.47832.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Frankly, I'd rather be working on improving drivers and helping implement
> > > the run-time power management than working on getting Suspend2 merged.
...
> Developmentwise, I think it's finished - unless I want to go off in a new 

I'd say that suspend2 already done its job -- forced me to do
uswsusp. I do not think it is mergeable without major refactoring.

Helping with runtime power management would be more welcome than
resubmitting same code over and over. Good news is that you can now do
what you prefer :-).

> > As far as the support for ordinary files, swap files, etc. is concerned,
> > there's nothing to worry about.  It's comming.
> 
> Great. It will be good to see that. Do you have some way around bmapping the 
> files?

You mean "some way to go without bmapping" or "did you get bmapping to
work" ?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
