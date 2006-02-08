Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWBHKCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWBHKCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBHKCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:02:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:35515 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932425AbWBHKCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:02:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 11:03:45 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080759.50579.rjw@sisk.pl> <200602081733.47134.nigel@suspend2.net>
In-Reply-To: <200602081733.47134.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081103.46156.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 08:33, Nigel Cunningham wrote:
> On Wednesday 08 February 2006 16:59, Rafael J. Wysocki wrote:
> > On Wednesday 08 February 2006 00:11, Nigel Cunningham wrote:
> > > On Wednesday 08 February 2006 09:02, Pavel Machek wrote:
}-- snip --{
> > > > Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> > > > currently best way to get that. It may be alpha/beta quality, but
> > > > someone has to start testing, and Lee should be good for that (played
> > > > with realtime kernels etc...). Actually it is in good enough state
> > > > that I'd like non-programmers to test it, too.
> > > 
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
> You seem to be the only person around who gets on well with him.

Well, that's probably because I always do my best to be nice and follow the
rules that Pavel sets.  I post patches to modify the existing code and not to
replace it top-down.  I keep them as compact as reasonably possible
and focus on one thing at a time.  I remove the parts that Pavel and other
people don't like or I try to modify these parts to be more acceptable.
Etc.  This is not _that_ difficult.

> Please, more people step up and tell me I'm wrong. I am only going off the
> mailing list afterall, and not daily personal interaction of some other kind.
> 
> > Moreover, I don't think the role of maintainer must be to actually write the
> > code.  From my point of view Pavel is in the right place, because I need
> > someone to tell me if I'm going to do something stupid who knows the kernel
> > better than I do.
> 
> By definition, if they don't maintain code, their not a maintainer. If they
> only tell someone that they're going to do something stupid, they're a
> code reviewer.

Well, this is your opinion.

In my opinion a maintainer need not be a developer.  The dictionary definition
of "to maintain" is "to keep a road, machine, building, etc. in good condition"
(http://dictionary.cambridge.org/define.asp?key=48204&dict=CALD)
which need not impy any development.

Greetings,
Rafael
