Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVE0Ro3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVE0Ro3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVE0Ro2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:44:28 -0400
Received: from gate.perex.cz ([82.113.61.162]:51433 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261969AbVE0Rnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:43:45 -0400
Date: Fri, 27 May 2005 19:43:44 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: ALSA official git repository
In-Reply-To: <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Linus Torvalds wrote:

> On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > 
> > 	I created new git tree for the ALSA project at:
> > 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> 
> Your scripts(?) to generate these things are a bit strange, since they
> leave an extra empty line in the commit message, which confuses at least
> gitweb (ie just look at
> 
>    http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary
> 
> and note how the summary thing looks empty).

Okay, sorry for this small bug. I'll recreate the ALSA git tree with
proper comments again. Also, the author is not correct (should be taken
from the first Signed-off-by:).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
