Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130039AbRBAFDc>; Thu, 1 Feb 2001 00:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130096AbRBAFDX>; Thu, 1 Feb 2001 00:03:23 -0500
Received: from moot.mb.ca ([64.4.83.10]:2577 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S130039AbRBAFDF>;
	Thu, 1 Feb 2001 00:03:05 -0500
Date: Wed, 31 Jan 2001 23:03:04 -0600 (CST)
From: "Michael J. Dikkema" <mjd@moot.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 - can't read root fs (devfs maybe?)
Message-ID: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I went from 2.4.0 to 2.4.1 and was surprised that either the root
filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
thinking there might have been a change with regards to the devfs
tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?

I can't even get a shell with init=/bin/bash.. 

Any help?

Thanks.

,.;::
: Michael J. Dikkema
| Systems / Network Admin - Internet Solutions, Inc.
| http://www.moot.ca   Work: (204) 982-1060
; mjd@moot.ca
',.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
