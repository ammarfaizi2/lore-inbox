Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTDTNAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTDTNAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:00:15 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:4026 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263568AbTDTNAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:00:14 -0400
Date: Sun, 20 Apr 2003 09:01:23 -0400
From: Ben Collins <bcollins@debian.org>
To: Shachar Shemesh <lkml@shemesh.biz>
Cc: Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
Message-ID: <20030420130123.GK2528@phunnypharm.org>
References: <20030417162723.GA29380@work.bitmover.com> <20030420013440.GG2528@phunnypharm.org> <3EA24CF8.5080609@shemesh.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA24CF8.5080609@shemesh.biz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 10:32:08AM +0300, Shachar Shemesh wrote:
> Ben Collins wrote:
> 
> >I hate asking this on top of the work you already provide, but would it
> >be possible to allow rsync access to the repo itself? I have atleast 6
> >computers on my LAN where I keep source trees (2.4 and 2.5), and it
> >would be much less b/w on my metered T1 and on your link aswell if I
> >could rsync one main "mirror" of the cvs repo and then point all my
> >machines at it.
> >
> There is a better tool (for this particular task), called "cvsup". It 
> does a wonderful job of keeping cvs repositories in synch. I realize I 
> just asked for a THIRD tool, so it should only go in if the admins are 
> willing to take care of it.

How does cvsup help when I have 6 copies of two different repositories
on my side and I only want to hit the other side one time to update all
6 copies?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
