Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVG1TQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVG1TQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVG1TQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:16:44 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18575 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262061AbVG1TGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:06:08 -0400
Subject: Re: [ALSA PATCH] 1.0.9b+
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jaroslav Kysela <perex@suse.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <20050728102525.234e6511.akpm@osdl.org>
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz>
	 <20050728102525.234e6511.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 15:06:02 -0400
Message-Id: <1122577563.2772.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 10:25 -0700, Andrew Morton wrote:
> Jaroslav Kysela <perex@suse.cz> wrote:
> >
> > Linus, please do an update from:
> > 
> >    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> > 
> > ...
> >   65 files changed, 5059 insertions(+), 1122 deletions(-)
> 
> The git-alsa.patch in -mm which I obtain from
> master.kernel.org:/pub/scm/linux/kernel/git/perex/alsa-current.git is
> empty.  So we're now wanting to merge 4,000 lines of unreviewed code which
> hasn't been tested in -mm at approximately the -rc4 stage.
> 

Lots of people install ALSA independently from the kernel (like all the
audio oriented distro users), probably a lot more than run -mm, so it's
not completely unreviewed.

Lee

