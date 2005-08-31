Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVHaOYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVHaOYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVHaOYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:24:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28045 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932515AbVHaOYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:24:05 -0400
Date: Wed, 31 Aug 2005 15:24:13 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050831142413.GB24383@gallifrey>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de> <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3smp (i686)
X-Uptime: 15:22:46 up 139 days, 13:54, 46 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Holger Kiehl (Holger.Kiehl@dwd.de) wrote:
> On Wed, 31 Aug 2005, Jens Axboe wrote:
> 
> Full vmstat session can be found under:

Have you got iostat?  iostat -x 10 might be interesting to see
for a period while it is going.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
