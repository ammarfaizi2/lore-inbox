Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWIENxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWIENxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWIENxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:53:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5868 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965065AbWIENxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:53:41 -0400
Subject: Re: [PATCHSET] The GFS2 filesystem (for review)
From: Steven Whitehouse <swhiteho@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       David Teigland <teigland@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <20060904194216.GA6953@ucw.cz>
References: <1157030815.3384.782.camel@quoit.chygwyn.com>
	 <20060901212759.GB4884@ucw.cz>
	 <1157375248.3384.914.camel@quoit.chygwyn.com>
	 <20060904194216.GA6953@ucw.cz>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 14:59:21 +0100
Message-Id: <1157464761.3384.1010.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 19:42 +0000, Pavel Machek wrote:
> Hi!
> 
> > > > Following on from this message are the 16 patches of GFS2 which we are
> > > > again posting for review. Since the last posting we have, I hope,
> > > > addressed all the issues raised as well as fixing a number of bugs. In
> > > > particular, we have now only one new exported symbol (see patch 16 of
> > > > the series).
> > > 
> > > I'm missing some Documentation/ so that I can learn what is gfs2 good
> > > for...
> 
> > Documentation/filesystems/gfs2.txt does exist... it was in patch 13, or
> > are you requesting that it should be a more detailed document? The
> > Kconfig file also has a brief description of GFS2 and what it can be
> > used for,
> 
> Sorry, I missed it. Perhaps Documentation should be in patch #1? ;-)
> 
> 							Pavel
Perhaps - I'll make a note to do that next time,

Steve.


