Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTDTBc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 21:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTDTBc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 21:32:58 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:53174 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263505AbTDTBc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 21:32:57 -0400
Date: Sat, 19 Apr 2003 21:34:40 -0400
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
Message-ID: <20030420013440.GG2528@phunnypharm.org>
References: <20030417162723.GA29380@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417162723.GA29380@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 09:27:23AM -0700, Larry McVoy wrote:
> It's back up, and the CVS server up to date with the 2.4 2.5 kernels as
> of a few minutes ago.  The CVS server is at
> 
> :pserver:anonymous@kernel.bkbits.net:/home/cvs 
> 
> There are linux-2.4/ and linux-2.5/ subdirectories there (should this go in
> a FAQ someplace or does nobody except Andrea care?).

I hate asking this on top of the work you already provide, but would it
be possible to allow rsync access to the repo itself? I have atleast 6
computers on my LAN where I keep source trees (2.4 and 2.5), and it
would be much less b/w on my metered T1 and on your link aswell if I
could rsync one main "mirror" of the cvs repo and then point all my
machines at it.

I do a lot of diff'ing and log reading, so it would help out there too
if I didn't have to connect back to bkbits to perform those frequent
operations.

No biggy if not.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
