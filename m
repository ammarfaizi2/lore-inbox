Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSHWIxv>; Fri, 23 Aug 2002 04:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSHWIxv>; Fri, 23 Aug 2002 04:53:51 -0400
Received: from gate.perex.cz ([194.212.165.105]:61446 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S318736AbSHWIxu>;
	Fri, 23 Aug 2002 04:53:50 -0400
Date: Fri, 23 Aug 2002 10:57:15 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA 0.9.0rc3
In-Reply-To: <20020822183156.A24470@infradead.org>
Message-ID: <Pine.LNX.4.33.0208231054410.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Christoph Hellwig wrote:

> On Wed, Aug 21, 2002 at 08:21:05PM +0200, Jaroslav Kysela wrote:
> > Hello,
> > 
> > 	Linus, please, apply these patches with latest ALSA code to 2.5 
> > tree:
> 
> Any chance you could stop that BK megachangeset and instead do one changeset
> per cvs commit?

I'll do more frequent syncing with the kernel tree in the future (I assume 
per week), but creating changesets per CVS commit is too overkill from the 
maintaince view. Everybody interested in ALSA development might watch 
our CVSLOG mailing list (archived) or use our CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

