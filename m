Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTBOTej>; Sat, 15 Feb 2003 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBOTej>; Sat, 15 Feb 2003 14:34:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15490
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264908AbTBOTei>; Sat, 15 Feb 2003 14:34:38 -0500
Subject: Re: openbkweb-0.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030215181211.GA12315@work.bitmover.com>
References: <20030214235724.GA24139@work.bitmover.com>
	 <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home>
	 <20030215181211.GA12315@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045341898.5130.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 15 Feb 2003 20:44:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-15 at 18:12, Larry McVoy wrote:
> All of this sounds great and is exactly what is already the plan.
> There is one missing item.  A consensus in the community that if we
> provide BK, the CVS mirror, bkbits hosting, in return the community
> agrees to leave off using BK to copy BK.

The community is an amorphous thing so thats tricky to define


For general kernel stuff I think a lot of people may not know that Rik
van Riel is generating 2 hourly diff sets between Linus tagged releases
and the head of the BK tree. So for the general "give me Linus kernel
right now case" - the big bandwidth eater its probably a lot simpler
for Larry to say "its on ftp.nl.linux.org" than waste time on code

-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>
