Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTCEWGj>; Wed, 5 Mar 2003 17:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTCEWGj>; Wed, 5 Mar 2003 17:06:39 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:58377 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265570AbTCEWGi>; Wed, 5 Mar 2003 17:06:38 -0500
Date: Wed, 5 Mar 2003 17:16:54 -0500
From: Ben Collins <bcollins@debian.org>
To: William Stearns <wstearns@pobox.com>
Cc: Sebastian Zimmermann <sebastian@expires1203.datenknoten.de>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ieee1394: sbp2: sbp2util_allocate_request_packet
Message-ID: <20030305221654.GC552@phunnypharm.org>
References: <20030305212148.GB552@phunnypharm.org> <Pine.LNX.4.44.0303051635300.3364-100000@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303051635300.3364-100000@sparrow>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I couldn't find a branches directory in the nightly tarball 
> link at http://www.linux1394.org/viewcvs/trunk/?root=Linux+IEEE-1394 .
> 
> 	Obviously I'm doing something wrong. :-)
> 	Is there some page on linux1394 which contains either a tar of the 
> current 2.4 tree or a the most recent patch against 2.4?
> 	My sincere thanks for all your work and help.

It's viewcvs (or viewsvn in this case). Browse the repo above (trunk
being HEAD). Unlink CVS, SVN stores branches in simple copies. The URL
you want is:

http://www.linux1394.org/viewcvs/branches/linux-2.4/?root=Linux+IEEE-1394


Then click on the tarball link at the bottom.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
