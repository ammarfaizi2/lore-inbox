Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWBGA3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWBGA3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBGA3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:29:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38616 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932420AbWBGA3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:29:31 -0500
Date: Tue, 7 Feb 2006 01:29:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207002910.GA1575@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl> <200602070957.39712.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602070957.39712.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This point is valid, but I don't think the users will _have_ _to_ switch
> > to the userland suspend.  AFAICT we are going to keep the kernel-based
> > code as long as necessary.
> >
> > We are just going to implement features in the user space that need not
> > be implemented in the kernel.  Of course they can be implemented in the
> > kernel, and you have shown that clearly, but since they need not be
> > there, we should at least try to implement them in the user space and
> > see how this works.
> >
> > Frankly, I have no strong opinion on whether they _should_ be
> > implemented in the user space or in the kernel, but I think we won't
> > know that until we actually _try_.
> >
> > That said, I like the idea and I'm going to work on it.  I'll also
> > appreciate any help very much.
> 
> Wow. I wish Pavel wrote replies like that. We'd get on a whole lot better. 
> 
> Pavel, am I doing something wrong that I'm not clicking to, which is 
> stirring you up? I really don't want to. I want to work with you guys 
> instead of against you, but it seems to me like every attempt at 
> interaction with you degenerates into something far less than ideal.

Nothing I could name... I guess I'll just let you cooperate with
Rafael, he can translate ;-).

[Well, perhaps there's one thing. Have you seen Al Viro's mails? He
tends to use quite a strong language. I guess asking you to talk like
him is too much to ask (but it would probably help ;-), but notice
that my and his native languages have quite a lot in common. Perhaps
I'm doing poor job translating into English at higher level...]

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
