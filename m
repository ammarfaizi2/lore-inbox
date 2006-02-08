Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWBHIPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWBHIPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWBHIPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:15:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030325AbWBHIPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:15:33 -0500
Date: Wed, 8 Feb 2006 09:15:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060208081509.GA10961@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080911.08090.nigel@suspend2.net> <200602080759.50579.rjw@sisk.pl> <200602081733.47134.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602081733.47134.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[I should probably left this reply to Rafael, but...]

> > > Ok. So Lee might be ok to test uswsusp. But this is your approach
> > > regardless of who is emailing you. You consistently tell people to fix
> > > problems themselves and send you a patch. That's not what a maintainer
> > > should do. They're supposed to maintain, not get other people to do the
> > > work. They're supposed to be helpful, not a source of anxiety. You might be
> > > the maintainer of swsusp in name, but you're not in practice. Please, lift
> > > your game!
> > 
> > I strongly disagree with this opinion.  I don't think there's any problem with
> > Pavel, at least I haven't had any problems in communicating with him.
> 
> You seem to be the only person around who gets on well with him. Please,
> more people step up and tell me I'm wrong. I am only going off the mailing
> list afterall, and not daily personal interaction of some other
> kind.

Well, on the other hand you are the only person that really has
problems with me.

> > Moreover, I don't think the role of maintainer must be to actually write the
> > code.  From my point of view Pavel is in the right place, because I need
> > someone to tell me if I'm going to do something stupid who knows the kernel
> > better than I do.
> 
> By definition, if they don't maintain code, their not a maintainer. If they
> only tell someone that they're going to do something stupid, they're a
> code reviewer.

You seem to be using different definition of maintainer than rest of
the world.

> > Furthermore, in many cases this is not Pavel who opposes your patches.
> 
> Other people have given feedback in the past that has been along the lines
> of suggesting improvements / cleanups / whatever, but (feel free to correct
> me) no one apart from him has written it off wholesale, told me I'm wasting
> my time or the like.
> 
> I want to get on with Pavel, I really do. But it's very hard when, despite my
> best efforts, trying to make allowances for possible misunderstandings and
> the like, I never seem to hear a helpful word from him. It's always "No.".
> "I don't want that.", and never (so far as I recall) "Here's how you could do
> that better..", "The idea is ok but the implementation is broken because..." or
> the like. Perhaps it is (as was said yesterday) just a cultural/language thing,
> but I'm not sure. 

If I rephrase my comments as:

"The idea is okay, but the implementation is broken, because it does
too much stuff in the kernel."

and

"Here's how you could do that better; take a look at latest -mm and
use facilities it provides to push most of suspend2 code into
userland."

...will that help?

> > As we speak there is a discussion on linux-pm regarding a patch that you
> > have submitted and I'm sure you are following it.  Please note that Pavel
> > hasn't spoken yet, but the patch has already been opposed by at least
> > two people.  Is _this_ a Pavel's fault?  No, it isn't.
> 
> I haven't seen any replies apart from yours so far. Perhaps there's something
> wrong with my mail delivery :(. I'll check the archives.

Oh... did not seen that mail thread. Please cc: me on suspend-related
stuff.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
