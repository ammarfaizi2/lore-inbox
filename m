Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270470AbTGZRmN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTGZRmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:42:13 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:54184 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270470AbTGZRmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:42:11 -0400
Date: Sat, 26 Jul 2003 13:45:37 -0400
From: Ben Collins <bcollins@debian.org>
To: gaxt <gaxt@rogers.com>, Torrey Hoffman <thoffman@arnor.net>,
       Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030726174537.GF490@phunnypharm.org>
References: <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net> <20030725201128.GA535@phunnypharm.org> <20030726165259.GV23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726165259.GV23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 09:52:59AM -0700, Chris Ruvolo wrote:
> On Fri, Jul 25, 2003 at 04:11:29PM -0400, Ben Collins wrote:
> > Kick ass. I've commited this change to the 1394 repo. Linus will get the
> > fix soon. I'll also send it to Marcelo for 2.4.22.
> > 
> > Please, if you are testing, use the code at www.linux1394.org's viewcvs
> > (trunk tarball will replace drivers/ieee1394 in 2.6, branches/linux-2.4
> > will do the same for 2.4).
> 
> Its all working!  Compiled the 1014 rev, and everything looks good.  dvgrab,
> kino, gscanbus, even GnomeMeeting 0.98 with /dev/video1394.
> 
> Thanks for all your help, and the time spent tracking down this problem!

Thanks for the feedback. I'm glad this is finally fixed.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
