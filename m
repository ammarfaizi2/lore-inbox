Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWGVBHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWGVBHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWGVBHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 21:07:30 -0400
Received: from xenotime.net ([66.160.160.81]:22415 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750773AbWGVBH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 21:07:29 -0400
Message-Id: <1153530447.22255@shark.he.net>
Date: Fri, 21 Jul 2006 18:07:27 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: David Lang <dlang@digitalinsight.com>,
       Matt LaPlante <kernel1@cyberdogtech.com>, linux-kernel@vger.kernel.org
Subject: Re: How long to wait on patches?
X-Mailer: WebMail 1.25
X-IPAddress: 216.191.251.226
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Fri, 21 Jul 2006, Matt LaPlante wrote:
> 
> > I checked the FAQ but didn't see an answer to this.  Over the past
few weeks 
> > I've submitted probably around 8 simple typo-fix patches all of
which seemed 
> > to be approved by others on the list.  I've been following the GIT,
but these 
> > patches haven't been merged yet.  I know people are busy with other
things, 
> > probably more important, but I would like to know how long is
"acceptable" to 
> > wait before I should re-submit a patch.  Obviously if enough time
passes, 
> > patches start to break as source files change.  I don't mean to be a
nuisance; 
> > I'm just trying to determine proper protocol.  That and the fact I
can submit 
> > several more patches once I get some of these old ones out of my
queue. :)
> 
> be sure to watch the -mm tree as well, a lot of patches are picked up
by Andrew 
> to be fed to Linus that way
> 
> this is a particularly bad week since almost all the core developers
were up at 
> OLS.
> 
> one thing you may want to look at doing (hosting permitting) is to
setup a git 
> tree to just hold your trivial patches so that they can be pulled easily.
> 
> I thought there was a person who was maintaining a -trivial tree for this 
> purpose, I don't remember who it was though.


Yes, Adrian Bunk accepts and forwards trivial patches. See
http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/

---
~Randy
