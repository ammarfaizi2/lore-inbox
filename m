Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWBGX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWBGX0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWBGX0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:26:08 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:29111 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030259AbWBGX0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:26:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 00:27:08 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071940.53843.nigel@suspend2.net> <20060207230245.GD2753@elf.ucw.cz>
In-Reply-To: <20060207230245.GD2753@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080027.09305.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 00:02, Pavel Machek wrote:
> > > > Personally I agree with you on suspend2, I think this is something that
> > > > needed to Just Work yesterday, and every day it doesn't work we are
> > > > losing users... but who am I to talk, I'm not the one who will have to
> > > > maintain it.
> > > 
> > > It does just work in mainline now. If it does not please open bug
> > > account at bugzilla.kernel.org.
> > > 
> > > If mainline swsusp is too slow for you, install uswsusp. If it is
> > > still too slow for you, mail me a patch adding LZW to userland code
> > > (should be easy).
> > 
> > <horrified rebuke>
> > 
> > Pavel!
> > 
> > Responses like this are precisely why you're not the most popular kernel 
> > maintainer. Telling people to use beta (alpha?) code or fix it
> 
> I do not *want* to be the most popular maintainer. That is your place ;-).
> 
> > themselves 
> > (and then have their patches rejected by you) is no way to maintain a part 
> > of the kernel. Stop being a liability instead of an asset!
> 
> Ugh?
> 
> Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> currently best way to get that. It may be alpha/beta quality, but
> someone has to start testing, and Lee should be good for that (played
> with realtime kernels etc...). Actually it is in good enough state
> that I'd like non-programmers to test it, too.

I'd rather like to wait with that until there's a howto. :-)

Greetings,
Rafael
