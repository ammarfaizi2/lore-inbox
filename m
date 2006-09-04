Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWIDTm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWIDTm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWIDTm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:42:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12294 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751105AbWIDTm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:42:28 -0400
Date: Mon, 4 Sep 2006 19:42:16 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       David Teigland <teigland@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCHSET] The GFS2 filesystem (for review)
Message-ID: <20060904194216.GA6953@ucw.cz>
References: <1157030815.3384.782.camel@quoit.chygwyn.com> <20060901212759.GB4884@ucw.cz> <1157375248.3384.914.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157375248.3384.914.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Following on from this message are the 16 patches of GFS2 which we are
> > > again posting for review. Since the last posting we have, I hope,
> > > addressed all the issues raised as well as fixing a number of bugs. In
> > > particular, we have now only one new exported symbol (see patch 16 of
> > > the series).
> > 
> > I'm missing some Documentation/ so that I can learn what is gfs2 good
> > for...

> Documentation/filesystems/gfs2.txt does exist... it was in patch 13, or
> are you requesting that it should be a more detailed document? The
> Kconfig file also has a brief description of GFS2 and what it can be
> used for,

Sorry, I missed it. Perhaps Documentation should be in patch #1? ;-)

							Pavel
-- 
Thanks for all the (sleeping) penguins.
