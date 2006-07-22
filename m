Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWGVCHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGVCHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 22:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWGVCHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 22:07:04 -0400
Received: from xenotime.net ([66.160.160.81]:55215 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751104AbWGVCHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 22:07:02 -0400
Message-Id: <1153534021.1550@shark.he.net>
Date: Fri, 21 Jul 2006 19:07:01 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>, David Lang <dlang@digitalinsight.com>,
       kernel1@cyberdogtech.com, linux-kernel@vger.kernel.org
Subject: Re: How long to wait on patches?
X-Mailer: WebMail 1.25
X-IPAddress: 216.191.251.226
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Fri, 21 Jul 2006 15:45:08 -0700 (PDT)
> David Lang <dlang@digitalinsight.com> wrote:
> 
> > > I checked the FAQ but didn't see an answer to this.  Over the past
few weeks 
> > > I've submitted probably around 8 simple typo-fix patches all of
which seemed 
> > > to be approved by others on the list.  I've been following the
GIT, but these 
> > > patches haven't been merged yet.  I know people are busy with
other things, 
> > > probably more important, but I would like to know how long is
"acceptable" to 
> > > wait before I should re-submit a patch.  Obviously if enough time
passes, 
> > > patches start to break as source files change.  I don't mean to be
a nuisance; 
> > > I'm just trying to determine proper protocol.  That and the fact I
can submit 
> > > several more patches once I get some of these old ones out of my
queue. :)
> > 
> > be sure to watch the -mm tree as well, a lot of patches are picked
up by Andrew 
> > to be fed to Linus that way
> 
> Yes, I hoover up unloved patches from the mailing list.  But only from
this
> mailing list, and there are probably lots of potentially-useful patches on
> other lists which get lost.
> 
> However I have a personal i-dont-do-typo-patches policy.  Resending
them to
> kernel-janitor-discuss@lists.sourceforge.net would be a good idea.

Please make that kernel-janitors@lists.osdl.org
The sf.net list/hosting is no longer used.

or just to trivial will also work.  Neither of them is especially
fast and should not be used for critical patches.

---
~Randy
