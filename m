Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVAFPmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVAFPmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVAFPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:40:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43686 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262883AbVAFPjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:39:00 -0500
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and
	ioctl_compat
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com,
       VANDROVE@vc.cvut.cz, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <20050106153147.GB19324@infradead.org>
References: <20041217014345.GA11926@mellanox.co.il>
	 <20050103011113.6f6c8f44.akpm@osdl.org>
	 <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de>
	 <20050105133448.59345b04.akpm@osdl.org>
	 <20050106140636.GE25629@mellanox.co.il>
	 <20050106145356.GA18725@infradead.org>
	 <20050106150941.GE1830@wotan.suse.de>
	 <20050106151429.GA19155@infradead.org>
	 <1105024942.13396.4.camel@krustophenia.net>
	 <20050106153147.GB19324@infradead.org>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 10:38:58 -0500
Message-Id: <1105025938.14990.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 15:31 +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 10:22:21AM -0500, Lee Revell wrote:
> > > p.s. droppe alsa-devel from Cc because of the braindead moderation policy.
> > > 
> > 
> > Um, alsa-devel is not moderated, we accept posts from non subscribers.
> > Where do you think all the spam in our archive comes from?
> 
> See the attached mail I got.  Btw, where are the current alsa-devel
> archives?  I tried to look things up a few times lately, but all archives
> linked off the websiste are either dead or totally outdated.
> 

OK, right, that's a problem.  There's no reason for that policy.  Perex,
can you fix it?

The only working up to date archive I know of is the sourceforge one,
not my favorite interface:

http://sourceforge.net/mailarchive/forum.php?forum_id=1752

Lee

