Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbTCGTI7>; Fri, 7 Mar 2003 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbTCGTI7>; Fri, 7 Mar 2003 14:08:59 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:4065 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S261710AbTCGTI5>; Fri, 7 Mar 2003 14:08:57 -0500
Date: Fri, 7 Mar 2003 11:19:19 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: WimMark I for 2.5.64-mm1
Message-ID: <20030307191919.GD2835@ca-server1.us.oracle.com>
References: <20030307175700.GA2835@ca-server1.us.oracle.com> <20030307104333.6f63c53a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307104333.6f63c53a.akpm@digeo.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 10:43:33AM -0800, Andrew Morton wrote:
> Is the difference between 2.5.64 and 2.5.64-mm1 statistically significant? 
> (It should be - the readahead changes).

	Yes, it is.  The average is noticeably different, and the high
number for 2.5.64 isn't much higher than the low number for 2.5.64-mm1.

Joel


-- 

Life's Little Instruction Book #157 

	"Take time to smell the roses."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
