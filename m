Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbTCGTGv>; Fri, 7 Mar 2003 14:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCGTGt>; Fri, 7 Mar 2003 14:06:49 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:24490 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261727AbTCGTGq>; Fri, 7 Mar 2003 14:06:46 -0500
Date: Fri, 7 Mar 2003 11:17:11 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Alex Riesen <alexander.riesen@synopsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I for 2.5.64-mm1
Message-ID: <20030307191710.GC2835@ca-server1.us.oracle.com>
References: <20030307175700.GA2835@ca-server1.us.oracle.com> <20030307180653.GA30288@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307180653.GA30288@riesen-pc.gr05.synopsys.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 07:06:53PM +0100, Alex Riesen wrote:
> > Runs with anticipatory scheduler:  547.28 580.69
> > Runs with deadline scheduler:  1557.79 1360.52
> 
> What do the numbers mean?
> Is AS better or worse DS?

	This is an OLTP setup, so the numbers are representative of
transactional load.  Bigger is better.

Joel


-- 

"The suffering man ought really to consume his own smoke; there is no 
 good in emitting smoke till you have made it into fire."
			- thomas carlyle

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
