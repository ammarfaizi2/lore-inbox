Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbTCTA2J>; Wed, 19 Mar 2003 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCTA2J>; Wed, 19 Mar 2003 19:28:09 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:13448 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S263174AbTCTA2I>; Wed, 19 Mar 2003 19:28:08 -0500
Date: Wed, 19 Mar 2003 16:38:58 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
Message-ID: <20030320003858.GM2835@ca-server1.us.oracle.com>
References: <20030319232812.GJ2835@ca-server1.us.oracle.com> <20030319175726.59d08fba.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319175726.59d08fba.akpm@digeo.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 05:57:26PM -0800, Andrew Morton wrote:
> Joel Becker <Joel.Becker@oracle.com> wrote:
> >
> > WimMark I report for 2.5.65-mm2
> > 
> > Runs:  1374.22 1487.19 1437.26
> > 
> 
> That is with elevator=as?

	Yes, it is as.  On Nick's recommendation I didn't consider a
deadline run a priority.  The regular deadline runs have been 1550-1590,
which is indeed statistically significant.

Joel

-- 

"In the beginning, the universe was created. This has made a lot 
 of people very angry, and is generally considered to have been a 
 bad move."
        - Douglas Adams

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
