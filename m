Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbSJMTx3>; Sun, 13 Oct 2002 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSJMTx3>; Sun, 13 Oct 2002 15:53:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:39328 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261608AbSJMTxX>;
	Sun, 13 Oct 2002 15:53:23 -0400
Message-ID: <3DA9D08B.EF8E1AF1@digeo.com>
Date: Sun, 13 Oct 2002 12:59:07 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: Brian Jackson <brian-kernel-list@mdrx.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: Linux v2.5.42
References: <20021013170630.29597.qmail@escalade.vistahp.com> <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 19:59:08.0003 (UTC) FILETIME=[FD794330:01C272F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> I'm bothered by other IBM influences, such as their fixation with
> performance of broken platforms like Profusion, or tuning for NUMA.

Actually it's rather useful to have these platforms around.  Because
if you fix a problem on profusion and NUMA-Q, it's really, really fixed
for other hardware...

They show up races and lock contention like crazy.
