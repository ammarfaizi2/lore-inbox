Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313365AbSDHOoa>; Mon, 8 Apr 2002 10:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313635AbSDHOo3>; Mon, 8 Apr 2002 10:44:29 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40197 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313365AbSDHOo3>; Mon, 8 Apr 2002 10:44:29 -0400
Date: Mon, 8 Apr 2002 10:41:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CB14ECD.43E97BD8@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1020408103532.21476A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Helge Hafting wrote:

> Why not?  Are you afraid that the spun-down disk won't
> start the next time it is needed?

  More to the point, afraid the hardware and o/s aren't perfectly
reliable, the battery life isn't infinite in any mode, etc, etc.

  There are many activities which have a large people time to bytes
written ratio, and I can appraciate that for many things you want a write
every N minutes if there is even one dirty buffer, where N is the
increment of person time you are willing to risk having to recreate.

  The tone of your posting implies that the risk of failure is low and it
is paranoid to worry that the disk will not spin. Obviously the previous
poster values think time highly, and I don't believe that concern should
be devalued, even by implication. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

