Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVE2JGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVE2JGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 05:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVE2JGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 05:06:37 -0400
Received: from gate.perex.cz ([82.113.61.162]:53228 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261289AbVE2JGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 05:06:34 -0400
Date: Sun, 29 May 2005 11:06:32 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: ALSA official git repository
In-Reply-To: <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.58.0505291103080.1748@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Jaroslav Kysela wrote:

> On Fri, 27 May 2005, Linus Torvalds wrote:
> 
> > On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > > 
> > > 	I created new git tree for the ALSA project at:
> > > 
> > > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> > 
> > Your scripts(?) to generate these things are a bit strange, since they
> > leave an extra empty line in the commit message, which confuses at least
> > gitweb (ie just look at
> > 
> >    http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary
> > 
> > and note how the summary thing looks empty).
> 
> Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> proper comments again. Also, the author is not correct (should be taken
> from the first Signed-off-by:).

The ALSA git tree is updated with all fixes now. I had an old git version 
which inserted this extra line at top of comments.

Also, it seems that there's a delay between master.kernel.org and git web 
interface at www.kernel.org (the changes are not on web yet).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
