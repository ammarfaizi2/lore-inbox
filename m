Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269283AbUJQUB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269283AbUJQUB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJQUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:01:57 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21675 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269283AbUJQUBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:01:54 -0400
Subject: Re: Building on case-insensitive systems
From: Albert Cahalan <albert@users.sf.net>
To: Dan Kegel <dank@kegel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4172A8FD.8000401@kegel.com>
References: <1097989574.2674.14246.camel@cube> <4171F741.2070209@kegel.com>
	 <1097991836.2666.14274.camel@cube>
	 <20041017092730.GA9081@mars.ravnborg.org>
	 <1098035748.2666.14288.camel@cube>  <4172A8FD.8000401@kegel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1098042896.2669.14306.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2004 15:54:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 13:16, Dan Kegel wrote:
> Albert Cahalan wrote:
> >>>>You are betting that you can force developers to switch away
> >>>>from Windows and MacOSX workstations.
> >>>
> >>>Actually, I'm betting that "required to build product"
> >>>is a magic phrase that overrides corporate IT's desire
> >>>to brutally enforce a Microsoft-only environment.
> >>
> >>Seems you are not part of one of these organisations.
> >>That argument will not suffice.
> > 
> > I was, twice, and it did suffice. Try it:
> > 
> > "needed for revenue generation"
> > "required to meet customer needs"
> > ...
> > 
> > Don't be taking away the ammo.
> > 
> > When the argument doesn't work, your organization
> > is obviously not fully committed to making a profit.
> > Politics are getting in the way. It's OK though,
> > since that just puts you at a market disadvantage.
> > Soon enough, the competiter will be hiring.
> 
> "Politics are just getting in the way"?
> Boy, that's the pot calling the kettle black...

Hey, fight fire with fire.

The ".s" suffix is deeply rooted in tradition.

Since MacOS can handle case-sensitive UFS filesystems,
and it has just been reported that Microsoft SFU also
supports being case-sensitive, the problem is solved.
The only change needed is the way a library is linked.

Bummer, actually.


